import { prisma } from '../prisma';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

export async function loginService(email: string, senha: string) {
  const user = await prisma.usuario.findUnique({ where: { email } });
  if (!user) return null;

  const ok = await bcrypt.compare(senha, user.senhaHash);
  if (!ok) return null;

  const token = jwt.sign(
    { sub: user.id, nome: user.nome, email: user.email },
    process.env.JWT_SECRET as string,
    { expiresIn: '7d' }
  );

  return { id: user.id, nome: user.nome, email: user.email, token };
}