# Portal FASI XIII Sumedang — Vercel + Neon

Frontend asli dipertahankan; backend Express berjalan sebagai Vercel Serverless Function dan data disimpan di Neon PostgreSQL.

## Deploy
1. Import repository ini ke Vercel.
2. Framework Preset: Other; Build Command kosong; Output Directory kosong; Install Command `npm install`.
3. Tambahkan Environment Variables: `DATABASE_URL` (Neon pooled connection string), `SESSION_SECRET` (acak minimal 32 karakter), `ADMIN_USERNAME`, `ADMIN_PASSWORD` (minimal 12 karakter).
4. Deploy. Saat endpoint API pertama dipanggil, tabel dan konten awal dibuat otomatis.

## Lokal
`npm install`, salin `.env.example` ke `.env`, isi variabel, lalu `npm start`.

Jangan pernah commit `.env`. Simpan repository sebagai Private. Ubah password admin setelah login pertama.
