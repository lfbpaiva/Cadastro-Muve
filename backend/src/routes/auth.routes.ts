import { Router } from 'express';
// idem: .js no import para ESM pós-build
import { registerController, loginController } from '../controllers/auth.controller.js';

const router = Router();

router.post('/register', registerController);
router.post('/login', loginController);

export default router;
