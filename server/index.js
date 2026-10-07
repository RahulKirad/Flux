import express from 'express';
import cors from 'cors';
import path from 'path';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

import authRoutes from './routes/authRoutes.js';
import serviceRoutes from './routes/serviceRoutes.js';
import projectRoutes from './routes/projectRoutes.js';
import industryRoutes from './routes/industryRoutes.js';
import caseStudyRoutes from './routes/caseStudyRoutes.js';
import blogRoutes from './routes/blogRoutes.js';
import certificationRoutes from './routes/certificationRoutes.js';
import facilityRoutes from './routes/facilityRoutes.js';
import careerRoutes from './routes/careerRoutes.js';
import leadRoutes from './routes/leadRoutes.js';
import mediaRoutes from './routes/mediaRoutes.js';
import settingsRoutes from './routes/settingsRoutes.js';
import siteContentRoutes from './routes/siteContentRoutes.js';
import { errorHandler, notFound } from './middleware/errorHandler.js';

dotenv.config();

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const app = express();

function normalizeOrigin(value) {
  return typeof value === 'string' ? value.trim().replace(/\/$/, '') : '';
}

const allowedOrigins = new Set(
  [
    process.env.CLIENT_URL,
    'http://localhost:5173',
    'http://127.0.0.1:5173',
    'https://fluxcorporation.in',
    'https://www.fluxcorporation.in',
  ]
    .map(normalizeOrigin)
    .filter(Boolean),
);

app.use(
  cors({
    origin(origin, callback) {
      if (!origin) {
        callback(null, true);
        return;
      }

      if (allowedOrigins.has(normalizeOrigin(origin))) {
        callback(null, true);
        return;
      }

      const err = new Error('Not allowed by CORS');
      err.statusCode = 403;
      callback(err);
    },
    credentials: true,
    optionsSuccessStatus: 204,
  }),
);
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.get('/api/health', (_req, res) => {
  res.json({ success: true, message: 'Flux Corp API is running', timestamp: new Date().toISOString() });
});

app.use('/api/auth', authRoutes);
app.use('/api/services', serviceRoutes);
app.use('/api/projects', projectRoutes);
app.use('/api/industries', industryRoutes);
app.use('/api/case-studies', caseStudyRoutes);
app.use('/api/blogs', blogRoutes);
app.use('/api/certifications', certificationRoutes);
app.use('/api/facilities', facilityRoutes);
app.use('/api/careers', careerRoutes);
app.use('/api/leads', leadRoutes);
app.use('/api/media', mediaRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/site-content', siteContentRoutes);

app.use(notFound);
app.use(errorHandler);

const PORT = process.env.PORT || 5001;
app.listen(PORT, () => {
  console.log(`Flux Corp API running on port ${PORT}`);
});

export default app;
