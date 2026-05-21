-- ============================================================
-- Jasmin Pansiyon Restaurant — Menü Verileri
-- schema.sql'den SONRA çalıştırın
-- ============================================================

-- Kategoriler
INSERT INTO categories (name_tr, name_en, name_ru, slug, sort_order, is_active) VALUES
  ('Salatalar',          'Salads',             'Салаты',                  'salatalar',       1, true),
  ('Fast Food',          'Fast Food',          'Фаст-фуд',                'fast-food',       2, true),
  ('Deniz Ürünleri',     'Seafood',            'Морепродукты',            'deniz-urunleri',  3, true),
  ('Izgaralar',          'Grilles',            'Гриль',                   'izgaralar',       4, true),
  ('Pizzalar',           'Pizzas',             'Пицца',                   'pizzalar',        5, true),
  ('Makarnalar',         'Pasta',              'Паста',                   'makarnalar',      6, true),
  ('Soğuk İçecekler',   'Cold Drinks',        'Холодные напитки',        'soguk-icecekler', 7, true),
  ('Sıcak İçecekler',   'Hot Drinks',         'Горячие напитки',         'sicak-icecekler', 8, true),
  ('Alkollü İçecekler',  'Alcoholic Drinks',   'Алкогольные напитки',     'alkol-icecekler', 9, true)
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- SALATALAR
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Sezar Salata',   'Caesar Salad',        'Цезарь салат',              600, 'TL', 1, true FROM categories WHERE slug='salatalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Akdeniz Salata', 'Mediterranean Salad', 'Средиземноморский салат',   450, 'TL', 2, true FROM categories WHERE slug='salatalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Çoban Salata',   'Shepherd''s Salad',   'Пастуший салат',            400, 'TL', 3, true FROM categories WHERE slug='salatalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Yeşil Salata',   'Green Salad',         'Салат из свежих овощей',    400, 'TL', 4, true FROM categories WHERE slug='salatalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Karışık Salata', 'Mixed Salad',         'Микс салат',                400, 'TL', 5, true FROM categories WHERE slug='salatalar';

-- ============================================================
-- FAST FOOD
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Hamburger',            'Hamburger',              'Гамбургер',                        550, 'TL', 1, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Cheese Burger',        'Cheese Burger',          'Чизбургер',                        700, 'TL', 2, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Patates Kızartması',   'Chips',                  'Чипсы',                            300, 'TL', 3, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Gözleme İspanaklı',   'Spinach Pancake',        'Гезлеме со шпинатом',              350, 'TL', 4, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Gözleme Peynirli',    'Cheese Pancake',         'Гезлеме с сыром',                  350, 'TL', 5, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Gözleme Patatesli',   'Potatoes Pancake',       'Гезлеме с картофелем',             350, 'TL', 6, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Gözleme Kıymalı',    'Minced Meat Pancake',    'Гезлеме с мясным фаршем',          450, 'TL', 7, true FROM categories WHERE slug='fast-food';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Mantı',               'Manti',                  'Манты',                            450, 'TL', 8, true FROM categories WHERE slug='fast-food';

-- ============================================================
-- DENİZ ÜRÜNLERİ
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Levrek',       'Sea Bass',          'Сибас',
  'Çips + Pirinç + Yeşillik + Zeytinyağı', 'Chips + Rice + Greens + Olive Oil', 'Чипсы + Рис + Зелень + Оливковое масло',
  700, 'TL', 1, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Çupra',        'Sea Bream',         'Дорадо',
  'Çips + Pirinç + Yeşillik + Zeytinyağı', 'Chips + Rice + Greens + Olive Oil', 'Чипсы + Рис + Зелень + Оливковое масло',
  700, 'TL', 2, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Somon Izgara', 'Grilled Salmon',    'Лосось на гриле',
  'Çips + Pirinç + Yeşillik', 'Chips + Rice + Greens', 'Чипсы + Рис + Зелень',
  750, 'TL', 3, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Somon Şiş',   'Salmon Shish',      'Шашлык из лосося',
  'Çips + Pirinç + Yeşillik', 'Chips + Rice + Greens', 'Чипсы + Рис + Зелень',
  700, 'TL', 4, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Akya Izgara',  'Grilled Amberjack', 'Лихия на гриле',
  'Çips + Pirinç + Yeşillik', 'Chips + Rice + Greens', 'Чипсы + Рис + Зелень',
  850, 'TL', 5, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Akya Şiş',    'Amberjack Shish',   'Шашлык из Лихии',
  'Çips + Pirinç + Yeşillik', 'Chips + Rice + Greens', 'Чипсы + Рис + Зелень',
  750, 'TL', 6, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Karides Güveç','Shrimp Casserole',  'Запеканка с креветками',
  'Domates + Biber + Sarımsak + Kaşar', 'Tomato + Pepper + Garlic + Cheese', 'Томат + Перец + Чеснок + Сыр',
  750, 'TL', 7, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Karides Tava', 'Fried Shrimp',      'Жареные креветки',
  'Çips + Pirinç + Yeşillik', 'Chips + Rice + Greens', 'Чипсы + Рис + Зелень',
  700, 'TL', 8, true FROM categories WHERE slug='deniz-urunleri';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kalamar Tava', 'Fried Calamari',    'Жареные кальмары',
  'Çips + Pirinç + Yeşillik', 'Chips + Rice + Greens', 'Чипсы + Рис + Зелень',
  800, 'TL', 9, true FROM categories WHERE slug='deniz-urunleri';

-- ============================================================
-- IZGARALAR
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kuzu Pirzola',  'Lamb Chop',         'Каре барашка',
  'Çips + Pirinç + Yeşillik + Salata', 'Chips + Rice + Greens + Salad', 'Чипсы + Рис + Зелень + Салат',
  1200, 'TL', 1, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Köfte',         'Meatball',          'Кёфте',
  'Çips + Pirinç + Salata', 'Chips + Rice + Salad', 'Чипсы + Рис + Салат',
  750, 'TL', 2, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'New York Steak','New York Steak',     'Стейк Нью Йорк',
  'Çips + Pirinç + Salata', 'Chips + Rice + Salad', 'Чипсы + Рис + Салат',
  1500, 'TL', 3, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Küşleme',       'Frontbine',         'Бон Филе из баранины',
  'Çips + Pirinç + Salata', 'Chips + Rice + Salad', 'Чипсы + Рис + Салат',
  1200, 'TL', 4, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Şiş',    'Chicken Shish',      'Куриный шашлык',
  'Çips + Pirinç + Yeşillik + Salata', 'Chips + Rice + Greens + Salad', 'Чипсы + Рис + Зелень + Салат',
  700, 'TL', 5, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Kanat',   'Chicken Wings',      'Куриные крылышки',
  'Çips + Pirinç + Salata', 'Chips + Rice + Salad', 'Чипсы + Рис + Салат',
  600, 'TL', 6, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Pirzola', 'Chicken Cutlet',     'Куриные бедра',
  'Çips + Pirinç + Salata', 'Chips + Rice + Salad', 'Чипсы + Рис + Салат',
  700, 'TL', 7, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kavurma',       'Roasting',           'Каварма из говядины',
  'Çips + Pirinç + Salata', 'Chips + Rice + Salad', 'Чипсы + Рис + Салат',
  700, 'TL', 8, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Adana Kebap',   'Adana Kebab',        'Адана кебаб',
  'Çips + Pirinç + Sumak Soğan', 'Chips + Rice + Sumac Onion', 'Чипсы + Рис + Лук с сумахом',
  800, 'TL', 9, true FROM categories WHERE slug='izgaralar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Urfa Kebap',    'Urfa Kebab',         'Урфа кебаб',
  'Çips + Pirinç + Sumak Soğan', 'Chips + Rice + Sumac Onion', 'Чипсы + Рис + Лук с сумахом',
  800, 'TL', 10, true FROM categories WHERE slug='izgaralar';

-- ============================================================
-- PIZZALAR
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Margarita',   'Margarita',   'Маргарита',      550, 'TL', 1, true FROM categories WHERE slug='pizzalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Karışık',     'Mixed',       'Ассорти',        600, 'TL', 2, true FROM categories WHERE slug='pizzalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Peperoni',    'Peperoni',    'Пепперони',      600, 'TL', 3, true FROM categories WHERE slug='pizzalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Vejeteryan',  'Vegetarian',  'Вегетарианская', 550, 'TL', 4, true FROM categories WHERE slug='pizzalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Mantarlı',    'With Mushroom','Грибная',       550, 'TL', 5, true FROM categories WHERE slug='pizzalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Ton Balıklı', 'With Tuna',   'С тунцом',      600, 'TL', 6, true FROM categories WHERE slug='pizzalar';

-- ============================================================
-- MAKARNALAR
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tavuk Kremalı',  'Chicken Creamy',  'Паста с курицей в сливочном соусе',
  'Tavuklu Krema Sos', 'Chicken Cream Sauce', 'Паста с курицей в сливочном соусе',
  650, 'TL', 1, true FROM categories WHERE slug='makarnalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Napolitan',      'Neapolitan',      'Неаполитанская',
  'Domates Sos', 'Tomato Sauce', 'Томатный соус',
  500, 'TL', 2, true FROM categories WHERE slug='makarnalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Mantar Kremalı', 'Mushroom Cream',  'Паста в грибном соусе',
  'Mantar Krema Sos', 'Mushroom Cream Sauce', 'Паста в грибном соусе',
  550, 'TL', 3, true FROM categories WHERE slug='makarnalar';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_tr, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Bolonez',        'Bolognese',       'Болоньезе',
  'Kıymalı Domates Sos', 'Minced Meat Tomato Sauce', 'Болоньезе',
  600, 'TL', 4, true FROM categories WHERE slug='makarnalar';

-- ============================================================
-- SOĞUK İÇECEKLER
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kola',                    'Cola',               'Кола',                 '0,33 L',               '0,33 л',               120, 'TL',  1, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kola Zero',               'Cola Zero',          'Кола зеро',            '0,33 L',               '0,33 л',               120, 'TL',  2, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Fanta',                   'Fanta',              'Фанта',                '0,33 L',               '0,33 л',               120, 'TL',  3, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Sprite',                  'Sprite',             'Спрайт',               '0,33 L',               '0,33 л',               120, 'TL',  4, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Su 1,5 L',               'Water 1.5L',         'Вода 1,5 л',           '1,5 L',                '1,5 л',                 90, 'TL',  5, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Su 0,5 L',               'Water 0.5L',         'Вода 0,5 л',           '0,5 L',                '0,5 л',                 50, 'TL',  6, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tamek Kayısı Suyu',       'Tamek Apricot Juice','Тамек абрикос',        'Tamek Apricot Juice 0,2 L', 'Холодный напиток из абрикоса 0,2 л', 120, 'TL',  7, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tamek Vişne Suyu',        'Tamek Cherry Juice', 'Тамек вишня',          'Tamek Cherry Juice 0,2 L',  'Холодный напиток из вишни 0,2 л',   120, 'TL',  8, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Tamek Şeftali Suyu',     'Tamek Peach Juice',  'Тамек персик',         'Tamek Peach Juice 0,2 L',   'Холодный напиток из персика 0,2 л', 120, 'TL',  9, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Ayran',                   'Ayran',              'Айран',                                                                             100, 'TL', 10, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Şalgam Acılı',           'Spicy Turnip',       'Шалгам острый',        'Spicy Turnip 0,3 L',   'Шалгам из репы острый 0,3 л',          120, 'TL', 11, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Şalgam',                 'Turnip',             'Шалгам',               'Turnip 0,3 L',         'Шалгам из репы 0,3 л',                 120, 'TL', 12, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Elde Sıkma Portakal Suyu','Fresh Orange Juice', 'Свежий апельсиновый сок','Fresh Orange Juice 0,33 L','Свежевыжатый апельсиновый сок 0,33 л',250,'TL', 13, true FROM categories WHERE slug='soguk-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Ice Tea Şeftali',        'Ice Tea Peach',      'Холодный чай персик',  'Ice Tea Peach 0,33 L', 'Холодный чай персиковый 0,33 л',       120, 'TL', 14, true FROM categories WHERE slug='soguk-icecekler';

-- ============================================================
-- SICAK İÇECEKLER
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Çay',          'Tea',            'Чай',               0, 'TL', 1, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Türk Kahvesi', 'Turkish Coffee', 'Турецкий кофе',     0, 'TL', 2, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Nescafe',      'Nescafe',        'Нескафе',           0, 'TL', 3, true FROM categories WHERE slug='sicak-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, price, currency, sort_order, is_active)
SELECT id, 'Filtre Kahve', 'Filter Coffee',  'Кофе зерновой',     0, 'TL', 4, true FROM categories WHERE slug='sicak-icecekler';

-- ============================================================
-- ALKOLLÜ İÇECEKLER
-- ============================================================
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Efes',              'Beer Efes',       'Пиво Эфес',         '0,5 L', '0,5 л',  250,   'TL',  1, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Tuborg',            'Beer Tuborg',     'Пиво Туборг',       '0,5 L', '0,5 л',  250,   'TL',  2, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Bomonti',           'Beer Bomonti',    'Пиво Бомонти',      '0,5 L', '0,5 л',  230,   'TL',  3, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Bira Carlsberg',         'Beer Carlsberg',  'Пиво Карлсберг',    '0,5 L', '0,5 л',  230,   'TL',  4, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı 100 cl',            'Raki 100 cl',     'Ракы 1000 мл',      '1000 ml','1000 мл',3000,  'TL',  5, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı 70 cl',             'Raki 70 cl',      'Ракы 700 мл',       '700 ml', '700 мл', 2800,  'TL',  6, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı 50 cl',             'Raki 50 cl',      'Ракы 500 мл',       '500 ml', '500 мл', 2500,  'TL',  7, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı 35 cl',             'Raki 35 cl',      'Ракы 350 мл',       '350 ml', '350 мл', 2000,  'TL',  8, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı 20 cl',             'Raki 20 cl',      'Ракы 200 мл',       '200 ml', '200 мл', 1500,  'TL',  9, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı Kadeh Duble',       'Raki Double',     'Ракы дабл',         '100 ml', '100 мл',  500,  'TL', 10, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Rakı Kadeh Tek',         'Raki Single',     'Ракы сингл',        '50 ml',  '50 мл',   350,  'TL', 11, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kırmızı Şarap',         'Red Wine',        'Вино красное',      '700 ml', '700 мл', 1500,  'TL', 12, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Kırmızı Şarap Kadeh',   'Red Wine Glass',  'Бокал красного',    '187,5 ml','187,5 мл', 400, 'TL', 13, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Beyaz Şarap',           'White Wine',      'Вино белое',        '700 ml', '700 мл', 1500,  'TL', 14, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Beyaz Şarap Kadeh',     'White Wine Glass','Бокал белого',      '187,5 ml','187,5 мл', 400, 'TL', 15, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Viski 100 ml',           'Whisky 100 ml',   'Виски 100 мл',      'Chivas 100 ml','Chivas 100 мл',   0, 'TL', 16, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Viski 50 ml',            'Whisky 50 ml',    'Виски 50 мл',       'Chivas 50 ml', 'Chivas 50 мл',    0, 'TL', 17, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Vodka 100 ml',           'Vodka 100 ml',    'Водка 100 мл',      '100 ml',       '100 мл',          0, 'TL', 18, true FROM categories WHERE slug='alkol-icecekler';
INSERT INTO products (category_id, name_tr, name_en, name_ru, description_en, description_ru, price, currency, sort_order, is_active)
SELECT id, 'Vodka 50 ml',            'Vodka 50 ml',     'Водка 50 мл',       '50 ml',        '50 мл',           0, 'TL', 19, true FROM categories WHERE slug='alkol-icecekler';
