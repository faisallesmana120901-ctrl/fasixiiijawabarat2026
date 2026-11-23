-- FASI XIII: pengamanan data admin
-- Jalankan di Supabase Dashboard > SQL Editor setelah akun Auth dibuat.

create table if not exists public.fasi_site_data (
  id text primary key check (id = 'main'),
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.fasi_site_data enable row level security;

drop policy if exists "Public can read FASI content" on public.fasi_site_data;
drop policy if exists "Authenticated admin can insert FASI content" on public.fasi_site_data;
drop policy if exists "Authenticated admin can update FASI content" on public.fasi_site_data;
drop policy if exists "Only designated admin can insert FASI content" on public.fasi_site_data;
drop policy if exists "Only designated admin can update FASI content" on public.fasi_site_data;

create policy "Public can read FASI content"
on public.fasi_site_data for select
to anon, authenticated
using (id = 'main');

create policy "Only designated admin can insert FASI content"
on public.fasi_site_data for insert
to authenticated
with check (
  id = 'main'
  and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
);

create policy "Only designated admin can update FASI content"
on public.fasi_site_data for update
to authenticated
using (
  id = 'main'
  and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
)
with check (
  id = 'main'
  and (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin'
);

update auth.users
set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb)
  || jsonb_build_object('role', 'admin')
where lower(email) = lower('faisallesmana120901@gmail.com');

update auth.users
set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) - 'role'
where lower(email) <> lower('faisallesmana120901@gmail.com')
  and raw_app_meta_data ->> 'role' = 'admin';

-- Pastikan akun admin sudah dibuat di Authentication > Users.
-- Nonaktifkan public sign-up di Supabase Auth.
-- Setelah SQL dijalankan, logout lalu login kembali agar JWT memuat role terbaru.
-- Jangan pernah menaruh service_role key di HTML.
