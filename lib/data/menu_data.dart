// Dữ liệu sản phẩm cho từng category
final Map<int, List<Map<String, dynamic>>> categoryProducts = {
  // Ưu đãi
  0: [
    {
      'title': 'COMBO NĂNG LƯỢNG',
      'price': 75000,
      'oldPrice': 99000,
      'discount': '-24%',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC-T51BJzl50EMbE9jUkw6aVhJFe5h52t7Dg&s',
    },
    {
      'title': 'COMBO LẤP LÁNH',
      'price': 159000,
      'oldPrice': 228000,
      'discount': '-30%',
      'imageUrl':
          'https://chus.vn/images/Blog/Tea%20of%20coffee/Coffee-or-Tea-For-Seniors-min.jpg?1712138278025',
    },
    {
      'title': 'Coffee & Donut',
      'price': 69000,
      'oldPrice': 99000,
      'discount': '-10%',
      'imageUrl':
          'https://www.phapfr.vn/nghe-thuat-song-du-lich/wp-content/uploads/sites/23/2021/05/cupfreshcoffeewithcroissants-73387856-1620723162001.jpg',
    },
  ],
  // Tea
  1: [
    {
      'title': 'Trà Đào',
      'price': 45000,
      'imageUrl':
          'https://hocphachehanoi.com.vn/upload/userfiles/images/cach-lam-tra-dao-02.jpg',
    },
    {
      'title': 'Trà Vải',
      'price': 45000,
      'imageUrl':
          'https://bizweb.dktcdn.net/100/421/036/files/tra-cam-sa-vai.jpg?v=1639043038068',
    },
    {
      'title': 'Trà Sen Vàng',
      'price': 50000,
      'imageUrl':
          'https://bepchethai.vn/wp-content/uploads/2023/02/tra-sen-vang-machiato-3-500x500.jpg',
    },
    {
      'title': 'Trà Dâu',
      'price': 50000,
      'imageUrl':
          'https://amivietnam.com/wp-content/uploads/2024/03/image-47.png',
    },
    {
      'title': 'Trà Trái Cây Nhiệt Đới',
      'price': 50000,
      'imageUrl':
          'https://cdn.sobanhang.com/v2/2000x2000/finan-prd/81d39d68-5ff6-4692-b918-a372b6bf6ab4/image/e416d0ab-993c-4efe-9dca-9a7b9e7372de.jpeg',
    },
    {
      'title': 'Trà Ổi Hồng',
      'price': 50000,
      'imageUrl':
          'https://cdn.tgdd.vn/2021/06/CookProductThumb/toh2-620x620.jpg',
    },
  ],
  // Coffee
  2: [
    {
      'title': 'Cà Phê Sữa Đá',
      'price': 35000,
      'imageUrl':
          'https://www.huongnghiepaau.com/wp-content/uploads/2024/07/cong-thuc-lam-ca-phe-sua-tuoi.jpg',
    },
    {
      'title': 'Bạc Xỉu',
      'price': 35000,
      'imageUrl': 'https://www.lorca.vn/wp-content/uploads/2023/10/1-29.jpg',
    },
    {
      'title': 'Cà Phê Đen Đá',
      'price': 32000,
      'imageUrl':
          'https://banhmibahuynh.vn/wp-content/uploads/2025/06/Ca-phe-den-da-Madam-Win.jpg',
    },
    {
      'title': 'Capuchino',
      'price': 45000,
      'imageUrl':
          'https://cdn1.123job.vn/123job/uploads/2021/09/27/2021_09_27______7c79422cc3229dbda950a5b5db38c2f6.jpg',
    },
    {
      'title': 'Cà Phê Trứng',
      'price': 45000,
      'imageUrl':
          'https://traphucsang.vn/wp-content/uploads/2025/08/cach-pha-ca-phe-trung-ngon-nhat.jpg',
    },
    {
      'title': 'Cà Phê Muối',
      'price': 45000,
      'imageUrl':
          'https://viettuantea.vn/wp-content/uploads/2023/09/cach-lam-ca-phe-muoi-1024x1024.jpg',
    },
  ],
  // Matcha
  3: [
    {
      'title': 'Matcha Latte',
      'price': 55000,
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrJrTp_PHyT7ifNbQ-DtZU6MQQ2mFe6mcnZg&s',
    },
    {
      'title': 'Matcha Đá Xay',
      'price': 60000,
      'imageUrl': 'https://thecoffeeholic.vn/storage/photos/2/H2M/ice/1.JPG',
    },
    {
      'title': 'Matcha Macchiato',
      'price': 58000,
      'imageUrl':
          'https://uories.com/wp-content/uploads/2020/03/MatchaMacchiato_www.uories.com_2.jpg',
    },
    {
      'title': 'Matcha Đậu đỏ',
      'price': 58000,
      'imageUrl':
          'https://horecavn.com/wp-content/uploads/2024/05/tra-sua-matcha-dau-do_20240527105057.jpg',
    },
    {
      'title': 'Matcha Dâu Latte',
      'price': 58000,
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSED-nzJRiHzcsJ9y6UUhlr0Etp8su7LENeDw&s',
    },
  ],
  // Milk Tea
  4: [
    {
      'title': 'Trà Sữa Trân Châu',
      'price': 48000,
      'imageUrl':
          'https://dayphache.edu.vn/wp-content/uploads/2020/02/mon-tra-sua-tran-chau.jpg',
    },
    {
      'title': 'Trà Sữa Ô Long',
      'price': 52000,
      'imageUrl':
          'https://static.wixstatic.com/media/57d3ad_eb3fc685e016483bbf860c01f0fdb13f~mv2.png/v1/fill/w_568,h_444,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/57d3ad_eb3fc685e016483bbf860c01f0fdb13f~mv2.png',
    },
    {
      'title': 'Trà Sữa Matcha',
      'price': 55000,
      'imageUrl':
          'https://file.hstatic.net/200000538679/article/cach-lam-tra-sua-matcha-chuan-vi-thom-ngon-tai-nha5_44906aa466224a9480f09cdc28f19e44.jpg',
    },
    {
      'title': 'Trà Sữa Thái xanh',
      'price': 40000,
      'imageUrl':
          'https://i-giadinh.vnecdn.net/2021/09/11/Trasua1-1631341310-9389-1631341336.jpg',
    },
    {
      'title': 'Sữa tươi trân châu đường đen',
      'price': 48000,
      'imageUrl':
          'https://blog.dktcdn.net/files/sua-tuoi-tran-chau-duong-den-001.png',
    },
  ],
  // Bánh
  5: [
    {
      'title': 'Bánh Mì Que',
      'price': 15000,
      'imageUrl':
          'https://tvpfood.com/wp-content/uploads/2024/10/banh-mi-que-minh-hoa-1-1.png',
    },
    {
      'title': 'Bánh Croissant',
      'price': 28000,
      'imageUrl': 'https://winci.com.vn/wp-content/uploads/2024/02/h-7.png',
    },
    {
      'title': 'Bánh Tiramisu',
      'price': 38000,
      'imageUrl':
          'https://daotaobeptruong.vn/wp-content/uploads/2020/11/banh-tiramisu.jpg',
    },
    {
      'title': 'Bánh Tiramisu Matcha',
      'price': 38000,
      'imageUrl':
          'https://cdn.tgdd.vn/2021/03/CookProduct/1200-1200x676-97.jpg',
    },
    {
      'title': 'Panna Cotta',
      'price': 40000,
      'imageUrl':
          'https://file.hstatic.net/200000692767/file/cach-lam-panna-cotta__3_.png',
    },
    {
      'title': 'Panna Cotta Coffee',
      'price': 44000,
      'imageUrl':
          'https://media.vneconomy.vn/images/upload/2021/04/21/ca-phe-15350831171861391119733.jpg?w=600',
    },
  ],
  // Topping
  6: [
    {
      'title': 'Trân Châu Đen',
      'price': 8000,
      'imageUrl':
          'https://chapatea.vn/wp-content/uploads/2025/01/tran-chau-den-8734.jpeg',
    },
    {
      'title': 'Trân Châu Trắng',
      'price': 10000,
      'imageUrl':
          'https://alltop.vn/backend/media/images/posts/695/Tran_Chau_Trang_3Q_Ezmix-128334.jpg',
    },
    {
      'title': 'Thạch Phô Mai',
      'price': 12000,
      'imageUrl':
          'https://storage.googleapis.com/onelife-public/blog.onelife.vn/2021/10/cach-lam-thach-rau-cau-ca-phe-pho-mai-mon-trang-mieng-780259497769.jpg',
    },
    {
      'title': 'Bánh Plan',
      'price': 10000,
      'imageUrl':
          'https://savourebakery.com/storage/images/san-pham/Banh-lanh/Banh-Flan-2.jpg',
    },
    {
      'title': 'Kem Cheese',
      'price': 12000,
      'imageUrl':
          'https://bizweb.dktcdn.net/100/439/247/products/5b9b880f-fb55-438f-9c89-adc684dc51bd.png?v=1656341171563',
    },
    {
      'title': 'Thạch dừa',
      'price': 9000,
      'imageUrl': 'https://goce.vn/files/common/thach-dua-huong-vai-5btgg.png',
    },
  ],
};
