import nodemailer from 'nodemailer';
import settingsRepository from '../repositories/settingsRepository.js';

let transporter;

async function getTransporter() {
  if (transporter) return transporter;

  const settings = await settingsRepository.getAllGrouped().catch(() => ({}));
  const emailSettings = settings.email || {};

  const host = process.env.SMTP_HOST || emailSettings.smtp_host;
  const port = Number(process.env.SMTP_PORT || emailSettings.smtp_port || 587);
  const user = process.env.SMTP_USER || emailSettings.smtp_user;
  const pass = process.env.SMTP_PASS || emailSettings.smtp_pass;

  if (!host || !user || !pass) return null;

  transporter = nodemailer.createTransport({
    host,
    port,
    secure: port === 465,
    auth: { user, pass },
  });

  return transporter;
}

async function getNotificationRecipient() {
  const settings = await settingsRepository.getAllGrouped().catch(() => ({}));
  return (
    process.env.LEAD_NOTIFICATION_EMAIL
    || settings.company?.company_email
    || process.env.SMTP_USER
  );
}

export async function sendLeadNotification(lead, { serviceName, serviceSlug } = {}) {
  const mailer = await getTransporter();
  const to = await getNotificationRecipient();
  if (!mailer || !to) return false;

  const settings = await settingsRepository.getAllGrouped().catch(() => ({}));
  const from = process.env.SMTP_FROM || settings.email?.smtp_from || process.env.SMTP_USER;

  const subject = serviceName
    ? `[Flux Corp] ${serviceName} consultation — ${lead.name}`
    : `[Flux Corp] New ${lead.source.replace(/_/g, ' ')} — ${lead.name}`;

  const lines = [
    'A new inquiry has been submitted on the Flux Corp website.',
    '',
    serviceName ? `Service: ${serviceName}` : null,
    serviceSlug ? `Service slug: ${serviceSlug}` : null,
    `Source: ${lead.source}`,
    `Name: ${lead.name}`,
    `Email: ${lead.email}`,
    lead.phone ? `Phone: ${lead.phone}` : null,
    lead.company ? `Company: ${lead.company}` : null,
    '',
    'Message:',
    lead.message || '(No message provided)',
  ].filter(Boolean);

  await mailer.sendMail({
    from,
    to,
    replyTo: lead.email,
    subject,
    text: lines.join('\n'),
  });

  return true;
}
