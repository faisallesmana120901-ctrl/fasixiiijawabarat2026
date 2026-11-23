-- Jalankan seluruh SQL ini di Supabase Dashboard > SQL Editor.
create table if not exists public.fasi_site_data (
  id text primary key check (id = 'main'),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.fasi_site_data enable row level security;

-- Pengunjung website hanya boleh membaca konten publik.
drop policy if exists "Public can read FASI content" on public.fasi_site_data;
create policy "Public can read FASI content"
on public.fasi_site_data for select
to anon, authenticated
using (id = 'main');

-- Hanya akun yang sudah login dapat menulis/memperbarui konten.
-- Pastikan hanya akun admin milik panitia yang dibuat di Supabase Auth.
drop policy if exists "Authenticated admin can insert FASI content" on public.fasi_site_data;
create policy "Authenticated admin can insert FASI content"
on public.fasi_site_data for insert
to authenticated
with check (id = 'main');

drop policy if exists "Authenticated admin can update FASI content" on public.fasi_site_data;
create policy "Authenticated admin can update FASI content"
on public.fasi_site_data for update
to authenticated
using (id = 'main')
with check (id = 'main');

-- Jangan aktifkan public sign-up. Buat akun admin secara manual melalui
-- Authentication > Users > Add user di dashboard Supabase.
