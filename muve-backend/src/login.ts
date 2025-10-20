import { Router } from "express";
import { PrismaClient, TipoPessoa } from "@prisma/client";
import bcrypt from "bcryptjs";

const router = Router();
const prisma = new PrismaClient();

// Registro
router.post("/register", async (req, res) => {
  try {
    const { nome, email, senha, telefone, tipoPessoa, cpf, cnpj, razaoSocial } = req.body ?? {};

    if (!nome || !email || !senha) {
      return res.status(400).json({ success: false, message: "nome, email e senha são obrigatórios" });
    }
    if (tipoPessoa === "PF" && !cpf) {
      return res.status(400).json({ success: false, message: "CPF é obrigatório para PF" });
    }
    if (tipoPessoa === "PJ" && (!cnpj || !razaoSocial)) {
      return res.status(400).json({ success: false, message: "CNPJ e razão social são obrigatórios para PJ" });
    }

    const hash = await bcrypt.hash(senha, 10);

    const user = await prisma.usuario.create({
      data: {
        nome,
        email,
        senha: hash,
        telefone,
        tipoPessoa: tipoPessoa === "PJ" ? TipoPessoa.PJ : TipoPessoa.PF,
        cpf: tipoPessoa === "PF" ? cpf : null,
        cnpj: tipoPessoa === "PJ" ? cnpj : null,
        razaoSocial: tipoPessoa === "PJ" ? razaoSocial : null,
      },
    });

    const { senha: _, ...safe } = user;
    return res.status(201).json({ success: true, user: safe });
  } catch (e: any) {
    if (String(e?.code) === "P2002") {
      return res.status(409).json({ success: false, message: "Email/CPF/CNPJ já cadastrado" });
    }
    console.error(e);
    return res.status(500).json({ success: false, message: "Erro interno" });
  }
});

// Login
router.post("/login", async (req, res) => {
  try {
    const { email, senha } = req.body ?? {};
    if (!email || !senha) {
      return res.status(400).json({ success: false, message: "email e senha são obrigatórios" });
    }

    const user = await prisma.usuario.findUnique({ where: { email } });
    if (!user) {
      return res.status(401).json({ success: false, message: "Credenciais inválidas" });
    }

    const ok = await bcrypt.compare(senha, user.senha);
    if (!ok) {
      return res.status(401).json({ success: false, message: "Credenciais inválidas" });
    }

    const { senha: _, ...safe } = user;
    return res.json({ success: true, user: safe });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ success: false, message: "Erro interno" });
  }
});

export default router;
