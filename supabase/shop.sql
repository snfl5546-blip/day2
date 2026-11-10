-- Supabase > SQL Editor 에서 이 파일 전체를 한 번에 실행하세요. (여러 번 실행해도 안전)

create table if not exists public.products (
  id          bigint generated always as identity primary key,
  name        text not null,
  description text not null default '',
  price       integer not null check (price >= 0),   -- 원 단위
  emoji       text not null default '🍊',
  category    text not null default '기타',
  created_at  timestamptz not null default now()
);

create table if not exists public.cart_items (
  id          bigint generated always as identity primary key,
  cart_id     text not null,                          -- 브라우저마다 다른 장바구니 번호
  product_id  bigint not null references public.products(id) on delete cascade,
  quantity    integer not null check (quantity between 1 and 99),
  created_at  timestamptz not null default now(),
  unique (cart_id, product_id)
);

-- 서버(secret key)만 접근 → 화면에서 직접 접근은 차단
alter table public.products   enable row level security;
alter table public.cart_items enable row level security;

-- 샘플 상품 (비어 있을 때만 넣기)
insert into public.products (name, description, price, emoji, category)
select * from (values
  ('제주 감귤 3kg',      '새콤달콤 노지 감귤, 당도 선별',            15900, '🍊', '과일'),
  ('한라봉 2kg',         '향이 진하고 과즙 가득한 프리미엄',          23900, '🍋', '과일'),
  ('흑돼지 오겹살 600g', '쫄깃한 육질, 멜젓 소스 포함',               32000, '🐖', '정육'),
  ('고등어 · 갈치 세트', '제주 바다 직송 손질 생선 세트',             39800, '🐟', '수산'),
  ('오메기떡 12입',      '쫀득한 제주 전통 떡, 팥고물',               14500, '🍡', '간식'),
  ('감귤 초콜릿 선물세트','귤피 가득, 선물용 포장',                    12800, '🍫', '간식'),
  ('한라산 녹차 티백',   '오설록 스타일 청정 녹차 40포',              11000, '🍵', '차'),
  ('제주 돌하르방 마그넷','여행 기념품, 손으로 만든 소품',              6500, '🗿', '기념품')
) as v(name, description, price, emoji, category)
where not exists (select 1 from public.products);
