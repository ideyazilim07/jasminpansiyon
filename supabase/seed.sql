-- ============================================================
-- Dijital QR Menü — Başlangıç Verileri
-- schema.sql'den SONRA çalıştırın
-- ============================================================

-- Kategoriler
INSERT INTO categories (name_tr, name_en, name_ru, slug, sort_order, is_active) VALUES
  ('Günlük Menü',               'Daily Menu',           'Дневное меню',             'gunluk-menu',                1, true),
  ('Ara Sıcaklar',              'Warm Appetizers',      'Горячие закуски',           'ara-sicaklar',               2, true),
  ('Salatalar',                 'Salads',               'Салаты',                   'salatalar',                  3, true),
  ('Makarnalar',                'Pasta',                'Паста',                    'makarnalar',                  4, true),
  ('Izgaralar ve Ana Yemekler', 'Grills & Main Dishes', 'Гриль и основные блюда',   'izgaralar-ve-ana-yemekler',  5, true),
  ('Deniz Ürünleri',            'Seafood',              'Морепродукты',             'deniz-urunleri',             6, true),
  ('Meşrubatlar',               'Soft Drinks',          'Безалкогольные напитки',   'mesrubatlar',                7, true),
  ('Alkollü İçecekler',         'Alcoholic Beverages',  'Алкогольные напитки',      'alkol-icecekler',            8, true),
  ('Sıcak İçecekler',           'Hot Beverages',        'Горячие напитки',          'sicak-icecekler',            9, true)
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- Günlük Menü
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Günün Çorbası',        'Soup of the Day',       'Суп дня',                  200, 'TL', 1, true FROM categories WHERE slug='gunluk-menu';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Günlük Sebze Yemeği', 'Daily Vegetable Meal',  'Блюдо из овощей',          350, 'TL', 2, true FROM categories WHERE slug='gunluk-menu';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Günlük Mezeler',      'Daily Appetizers',      'Закуски дня',              250, 'TL', 3, true FROM categories WHERE slug='gunluk-menu';

-- ============================================================
-- Ara Sıcaklar
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Cips',              'Chips',                    'Чипсы',                300, 'TL', 1, true FROM categories WHERE slug='ara-sicaklar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Sigara Böreği',    'Cheese Rolls',             'Сигара-бёрек',         280, 'TL', 2, true FROM categories WHERE slug='ara-sicaklar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Karışık Kızartma', 'Mixed Fried Vegetables',  'Смешанная жарка',      450, 'TL', 3, true FROM categories WHERE slug='ara-sicaklar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Menemen',          'Vegetable Scrambled Eggs', 'Менемен',              400, 'TL', 4, true FROM categories WHERE slug='ara-sicaklar';

-- ============================================================
-- Salatalar
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Mevsim Salata',    'Season Salad',         'Сезонный салат',   350, 'TL', 1, true FROM categories WHERE slug='salatalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Çoban Salata',     'Shepherd Salad',       'Чобан салат',      350, 'TL', 2, true FROM categories WHERE slug='salatalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Ton Balıklı Salata','Tuna Salad',           'Салат с тунцом',   450, 'TL', 3, true FROM categories WHERE slug='salatalar';

-- ============================================================
-- Makarnalar
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Spagetti Bolonez',               'Spaghetti Bolognese',           'Спагетти болоньезе',              450, 'TL', 1, true FROM categories WHERE slug='makarnalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Spagetti Napoliten',             'Spaghetti Napoletana',          'Спагетти неаполитана',            400, 'TL', 2, true FROM categories WHERE slug='makarnalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Ton Balıklı Domates Soslu Spagetti','Tuna Spaghetti in Tomato Sauce','Спагетти с тунцом в томатном соусе',450,'TL',3, true FROM categories WHERE slug='makarnalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Mantı',                          'Turkish Ravioli',               'Манты',                           450, 'TL', 4, true FROM categories WHERE slug='makarnalar';

-- ============================================================
-- Izgaralar ve Ana Yemekler
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Kavurma',      'Cooked Diced Meat',    'Тушёное мясо',         850, 'TL', 1, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Köfte',        'Meatballs',            'Кёфте',                600, 'TL', 2, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Pirzola','Chicken Schnitzel',    'Куриная отбивная',     500, 'TL', 3, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Şiş',   'Chicken Shish Kebab',  'Куриный шашлык',       500, 'TL', 4, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Kanat', 'Chicken Wings',         'Куриные крылья',       500, 'TL', 5, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Kuzu Pirzola','Lamb Chops',            'Бараньи отбивные',     900, 'TL', 6, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Kuzu Şiş',   'Lamb Shish Kebab',      'Баранний шашлык',      850, 'TL', 7, true FROM categories WHERE slug='izgaralar-ve-ana-yemekler';

-- ============================================================
-- Deniz Ürünleri
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Kalamar',       'Fried Calamari',     'Жареные кальмары',  600, 'TL', 1, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Karides Güveç', 'Shrimp Casserole',   'Рагу из креветок',  600, 'TL', 2, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Çupra',         'Sea Bream',          'Дорада',            600, 'TL', 3, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Levrek',        'Sea Bass',           'Сибас',             600, 'TL', 4, true FROM categories WHERE slug='deniz-urunleri';

-- ============================================================
-- Meşrubatlar
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Cola',          'Cola',         'Кола',                  90, 'TL', 1,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Fanta',         'Fanta',        'Фанта',                 90, 'TL', 2,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Sprite',        'Sprite',       'Спрайт',                90, 'TL', 3,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Büyük Su',      'Large Water',  'Большая вода',          50, 'TL', 4,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Küçük Su',      'Small Water',  'Маленькая вода',        25, 'TL', 5,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Maden Suyu',    'Sparkling Water','Газированная вода',   75, 'TL', 6,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Portakal Suyu', 'Orange Juice', 'Апельсиновый сок',     120, 'TL', 7,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Ayran',         'Ayran',        'Айран',                  90, 'TL', 8,  true FROM categories WHERE slug='mesrubatlar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Türk Kahvesi',  'Turkish Coffee','Турецкий кофе',        120, 'TL', 9,  true FROM categories WHERE slug='mesrubatlar';

-- ============================================================
-- Alkollü İçecekler
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Efes',       'Efes Beer',     'Пиво Эфес',     200,  'TL', 1,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Tuborg',     'Tuborg Beer',   'Пиво Туборг',   200,  'TL', 2,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Miller',     'Miller Beer',   'Пиво Миллер',   200,  'TL', 3,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Şarap Şişe',     'Wine Bottle',   'Бутылка вина',  850,  'TL', 4,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Şarap Kadeh',    'Wine Glass',    'Бокал вина',    350,  'TL', 5,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Yeni Rakı 20 cl','Yeni Rakı 20cl','Ракы 20 мл',    800,  'TL', 6,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Yeni Rakı 35 cl','Yeni Rakı 35cl','Ракы 35 мл',    1150, 'TL', 7,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Yeni Rakı 50 cl','Yeni Rakı 50cl','Ракы 50 мл',    1500, 'TL', 8,  true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Yeni Rakı 70 cl','Yeni Rakı 70cl','Ракы 70 мл',    1950, 'TL', 9,  true FROM categories WHERE slug='alkol-icecekler';

-- ============================================================
-- Sıcak İçecekler
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Espresso',          'Espresso',          'Эспрессо',               120, 'TL', 1, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Americano',         'Americano',         'Американо',              120, 'TL', 2, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Latte',             'Latte',             'Латте',                  150, 'TL', 3, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Cappuccino',        'Cappuccino',        'Капучино',               150, 'TL', 4, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Sütlü Filtre Kahve','Milk Filter Coffee','Фильтр-кофе с молоком', 150, 'TL', 5, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Türk Kahvesi',      'Turkish Coffee',    'Турецкий кофе',          120, 'TL', 6, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Demlik Çay Pot',    'Teapot Tea',        'Чайник с чаем',         450, 'TL', 7, true FROM categories WHERE slug='sicak-icecekler';
