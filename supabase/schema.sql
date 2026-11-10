-- Supabase SQL Editor 에서 한 번 실행하세요.
create table if not exists public.notes (
  id bigint generated always as identity primary key,
  content text not null,
  created_at timestamptz not null default now()
);
-- 백엔드는 secret key(서버 전용)로 접근하므로 RLS를 켜서 외부 직접 접근은 막아둡니다.
alter table public.notes enable row level security;
