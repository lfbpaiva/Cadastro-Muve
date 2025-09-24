// src/controllers/auth.controller.ts
import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();
const SALT_ROUNDS = parseInt(process.env.BCRYPT_SALT_ROUNDS || "10", 10);

// Util: normaliza e valida campos básicos
function normalizeEmail(email: string) {
  return email.trim().toLowerCase();
}
function isBlank(v?: string) {
  return !v || v.trim().length === 0;
}
function safeUser(u: { id: number; nome: string; email: string }) {
  return { id: u.id, nome: u.nome, email: u.email };
}

/**
 * POST /auth/register
 * Body: { nome, email, senha }
 * Cria um usuário com senha hasheada (bcryptjs).
 */
export async function registerController(req: Request, res: Response) {
  let { nome, email, senha } = req.body as {
    nome?: string;
    email?: string;
    senha?: string;
  };

  if (isBlank(nome) || isBlank(email) || isBlank(senha)) {
    return res.status(400).json({
      success: false,
      message: "nome, email e senha são obrigatórios",
    });
  }

  try {
    email = normalizeEmail(email!);

    // opcional: política mínima de senha
    if ((senha as string).length < 6) {
      return res.status(400).json({
        success: false,
        message: "A senha deve ter pelo menos 6 caracteres",
      });
    }

    const senhaHash = await bcrypt.hash(senha!, SALT_ROUNDS);

    const novoUsuario = await prisma.usuario.create({
      data: { nome: nome!.trim(), email, senha: senhaHash },
      select: { id: true, nome: true, email: true },
    });

    return res.status(201).json({ success: true, user: novoUsuario });
  } catch (err: any) {
    // Prisma P2002 = violação de unique (email já usado)
    if (err?.code === "P2002") {
      return res
        .status(409)
        .json({ success: false, message: "E-mail já cadastrado" });
    }
    console.error("registerController error:", err);
    return res
      .status(500)
      .json({ success: false, message: "Erro ao registrar usuário" });
  }
}

/**
 * POST /auth/login
 * Body: { email, senha }
 * Valida credenciais comparando bcrypt hash.
 */
export async function loginController(req: Request, res: Response) {
  let { email, senha } = req.body as { email?: string; senha?: string };

  if (isBlank(email) || isBlank(senha)) {
    return res.status(400).json({
      success: false,
      message: "email e senha são obrigatórios",
    });
  }

  try {
    email = normalizeEmail(email!);

    const user = await prisma.usuario.findUnique({
      where: { email },
      // lê somente o necessário (inclui hash para comparar)
      select: { id: true, nome: true, email: true, senha: true },
    });

    if (!user) {
      return res
        .status(401)
        .json({ success: false, message: "Credenciais inválidas" });
    }

    const ok = await bcrypt.compare(senha!, user.senha);
    if (!ok) {
      return res
        .status(401)
        .json({ success: false, message: "Credenciais inválidas" });
    }

    // Nunca devolva a senha; responda com dados públicos
    return res.json({
      success: true,
      user: safeUser(user),
    });
  } catch (err) {
    console.error("loginController error:", err);
    return res
      .status(500)
      .json({ success: false, message: "Erro interno no servidor" });
  }
}
