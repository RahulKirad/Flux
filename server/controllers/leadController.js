import leadRepository from '../repositories/leadRepository.js';
import pool from '../config/database.js';
import XLSX from 'xlsx';

export const createLead = async (req, res) => {
  const lead = await leadRepository.create(req.body);
  res.status(201).json({ success: true, data: lead, message: 'Thank you! We will contact you soon.' });
};

export const getLeads = async (req, res) => {
  const leads = await leadRepository.findAllWithDetails(req.query);
  res.json({ success: true, data: leads });
};

export const updateLead = async (req, res) => {
  const lead = await leadRepository.update(req.params.id, req.body);
  res.json({ success: true, data: lead });
};

export const addFollowUpNote = async (req, res) => {
  const lead = await leadRepository.findById(req.params.id);
  const notes = typeof lead.follow_up_notes === 'string'
    ? JSON.parse(lead.follow_up_notes || '[]')
    : (lead.follow_up_notes || []);

  notes.push({
    note: req.body.note,
    user: req.user.name,
    date: new Date().toISOString(),
  });

  const updated = await leadRepository.update(req.params.id, {
    follow_up_notes: JSON.stringify(notes),
    status: req.body.status || lead.status,
  });
  res.json({ success: true, data: updated });
};

export const exportLeads = async (_req, res) => {
  const leads = await leadRepository.findAllWithDetails({ limit: 10000 });
  const ws = XLSX.utils.json_to_sheet(leads.map(({ follow_up_notes, ...l }) => l));
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, 'Leads');
  const buffer = XLSX.write(wb, { type: 'buffer', bookType: 'xlsx' });
  res.setHeader('Content-Disposition', 'attachment; filename=flux-corp-leads.xlsx');
  res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.send(buffer);
};

export const createInquiry = async (req, res) => {
  const keys = Object.keys(req.body);
  const values = Object.values(req.body);
  const [result] = await pool.execute(
    `INSERT INTO inquiries (${keys.join(', ')}) VALUES (${keys.map(() => '?').join(', ')})`,
    values
  );
  res.status(201).json({ success: true, message: 'Inquiry submitted successfully', id: result.insertId });
};

export const getInquiries = async (_req, res) => {
  const [inquiries] = await pool.execute('SELECT * FROM inquiries ORDER BY created_at DESC');
  res.json({ success: true, data: inquiries });
};

export const markInquiryRead = async (req, res) => {
  await pool.execute('UPDATE inquiries SET is_read = 1 WHERE id = ?', [req.params.id]);
  res.json({ success: true, message: 'Marked as read' });
};
