

import 'package:bragasapps1/Profile/UserCalander.dart';
import 'package:bragasapps1/allLoginPage/allLoginPage.dart';
import 'package:bragasapps1/core.dart';

import 'package:bragasapps1/dashboardALL/dashboardMain.dart';




class CarouselData {
  static List<Map<String, dynamic>> imagesWithText = [
    {
      'imageUrl':
          'https://media.istockphoto.com/id/172242555/photo/towering-clouds-and-lonely-tree.webp?b=1&s=170667a&w=0&k=20&c=lVe1wzP630bjkdC0s6hBo9N7O_QhZkp-adXeOaQymCk=',
      'kerunai': 'G7',
      'harga': 'Rm 400',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/172860012/photo/the-rinjani-volcano.webp?b=1&s=170667a&w=0&k=20&c=z9oQHg4CF8jz2Prke-Gu2vWK05WcXQz0YpsGxi3U5aI=',
      'kerunai': 'KERUNAI',
      'harga': 'Rm 200',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/485954116/photo/rice-field-facing-the-rinjani-volcano-in-lombok.webp?b=1&s=170667a&w=0&k=20&c=sulG0vN5LJsJis-KAsuMJxYyiXXKofjoaZ9aOVnFgeg=',
      'kerunai': 'RINJANI',
      'harga': 'Rm 300',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/1475629077/photo/waiting-for-the-sun-is-coming-out.webp?b=1&s=170667a&w=0&k=20&c=yHNMwrnoodvd419lv0cXsFk49G7XFbWXLZPSN2IO2do=',
      'kerunai': 'BROGA',
      'harga': 'RM200',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/1428276270/photo/sunrise-at-rinjani-summit.webp?b=1&s=170667a&w=0&k=20&c=Utl8F9fTM1X4fHALqSPnvcYqT6cuGZ5fVjdNcahQ8Ts=',
      'kerunai': 'BEREKEH',
      'harga': 'Harga 150',
    },
  ];
}

class ShoppingData {
  List<Map<String, dynamic>> products = [
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHJNLIO4BWJe5o1VOSEUlq2W-wOAZcuKAG4g&usqp=CAU",
      'k': 'Baju bulu hidung',
      'harga': 'Rm 400',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOc18jHH6kSKp5Wjh_mqfetbNE-kHhHjKC5Q&usqp=CAU",
      'k': 'BAju Bulu Kambing',
      'harga': 'Rm 200',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9KkhvICu6sJIDbriyK8NJO-MDmvI8y3k8Tg&usqp=CAU",
      'k': 'seluar tutp aurat',
      'harga': 'Rm 300',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbZprP7E40Z97VbnLr-rtfMw_huf2CDZ0yBQ&usqp=CAU",
      'k': 'seluar lelaki',
      'harga': 'RM200',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIk9csJ1SJ0XqAs3GreGBH0QbHweWf3zjg7g&usqp=CAU",
      'k': 'beg mayat',
      'harga': 'Harga 150',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1mObOLVIw4Tvg3CTbZhGHhBqCBgm8r6-LTQ&usqp=CAU",
      'k': 'beg member ',
      'harga': 'Harga 150',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCSByMAHlnroAJQFXfAPPc-sPPDPRMj1vy2w&usqp=CAU",
      'k': 'kasut masjid',
      'harga': 'Harga 150',
    },
    {
      'imageUrl':
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpZuNzkdvkD_zLdlqAKvKWSdvfTG9796NSXw&usqp=CAU",
      'k': 'kasut jiran',
      'harga': 'Harga 750',
    },
  ];
}

class Textdata {
  List Text1 = [
    // "SELUAR",
    "BAJU",
    "KASUT",
    // "BEG",
  ];
}

class Bajushop {
  List<Map<String, dynamic>> bajushop = [
   {
      "assetPath": "assets/baju1.png",
      'k': 'baju 1 ',
      'harga':  50,
    },
   
    {
      "assetPath": "assets/baju2.png",
      'k': 'baju 2  ',
      'harga': 50,
    },
      {
      "assetPath": "assets/baju3.png",
      'k': 'baju 3 ',
      'harga':  50,
    },
      {
      "assetPath": "assets/baju4.png",
      'k': 'baju 4 ',
      'harga': 50,
    },
      {
      "assetPath": "assets/baju5.png",
      'k': 'baju 5',
      'harga': 70,
    },
  ];
}


class Kasutshop {
  List<Map<String, dynamic>> kasutshop = [
    {
      "assetPath": "assets/asic1.png",
      'k': 'ASIC 1 HIKING ',
      'harga': 400,
    },
   
    {
      "assetPath": "assets/asic2.png",
      'k': 'ASIC 2 HIKING ',
      'harga': 200,
    },
      {
      "assetPath": "assets/asic3.png",
      'k': 'ASIC 3 HIKING ',
      'harga':  150,
    },
      {
      "assetPath": "assets/asic4.png",
      'k': 'ASIC 4 HIKING ',
      'harga':  400,
    },
      {
      "assetPath": "assets/asic5.png",
      'k': 'ASIC 5 HIKING ',
      'harga': 400,
    },
  ];


}

class Profile {
  List<Map<String, dynamic>> profileitem = [
    {
      "label": "Edit Profile",
      "view": dashMain(),
    },
   
    {
    //   "label": "Shopping",
    //   "view": viewRegisterTripHistory(),
    // },
    // {
    //   "label": "Trip",
    //   "view":tripRegisterform (),
    // },
    // {
      "label": "Calendar",
      "view": dashMain(),
    },
     {
      "label": "compass",
      // "view": CompassApp(),
    },
   
   {
      "label": "Logout",
      "view": LoginPage2(),
    },
  ];
}



class PopularMap {
  List<Map<String, dynamic>> imagesWithText = [
    {
      'imageUrl':
          'https://media.istockphoto.com/id/172242555/photo/towering-clouds-and-lonely-tree.webp?b=1&s=170667a&w=0&k=20&c=lVe1wzP630bjkdC0s6hBo9N7O_QhZkp-adXeOaQymCk=',
      'Type': 'Trip1',
      'harga': 'Rm 400',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/172860012/photo/the-rinjani-volcano.webp?b=1&s=170667a&w=0&k=20&c=z9oQHg4CF8jz2Prke-Gu2vWK05WcXQz0YpsGxi3U5aI=',
      'Type': 'Trip2',
      'harga': 'Rm 200',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/485954116/photo/rice-field-facing-the-rinjani-volcano-in-lombok.webp?b=1&s=170667a&w=0&k=20&c=sulG0vN5LJsJis-KAsuMJxYyiXXKofjoaZ9aOVnFgeg=',
      'Type': 'Trip3',
      'harga': 'Rm 300',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/1475629077/photo/waiting-for-the-sun-is-coming-out.webp?b=1&s=170667a&w=0&k=20&c=yHNMwrnoodvd419lv0cXsFk49G7XFbWXLZPSN2IO2do=',
      'Type': 'Trip4',
      'harga': 'RM200',
    },
    {
      'imageUrl':
          'https://media.istockphoto.com/id/1428276270/photo/sunrise-at-rinjani-summit.webp?b=1&s=170667a&w=0&k=20&c=Utl8F9fTM1X4fHALqSPnvcYqT6cuGZ5fVjdNcahQ8Ts=',
      'Type': 'Trip5',
      'harga': 'Harga 150',
    },
  ];
}

class MountMap {
  List<Map<String, dynamic>> imagesWithText = [
    {
     'imageUrl':
     "https://media.istockphoto.com/id/1220337970/photo/mystic-moody-view-around-mount-ijen.jpg?s=612x612&w=0&k=20&c=zpVPYCacwP2DSS1gteXllr9StvUPGyBC9h8p1CgDVqM=",
      'kerunai': 'Gunung Pulai',
      // 'harga': 'Rm 400/NIGHT',
    },
    {
       'imageUrl':
          "https://media.istockphoto.com/id/1455864269/photo/stunning-scenic-mountain-ranges-and-nature-area-in-montana-summertime.webp?b=1&s=170667a&w=0&k=20&c=Ebn8d5RHjdgJWl4B_LPy6XtgZFBlH2yTaO2pb1yq3DI=",
      'kerunai': 'Gunung Alai',
      // 'harga': 'Rm 400',
    },
    {
       'imageUrl':
          "https://www.goodnewsfromindonesia.id/wp-content/uploads/images/source/thomasbenmetan/DSCF1545.JPG",
      'kerunai': 'Gunung arau',
      // 'harga': 'RM40',
    },
    {
     'imageUrl':
          "https://media.istockphoto.com/id/474267374/photo/reflections-on-a-lake.webp?b=1&s=170667a&w=0&k=20&c=8VDTbBQy-MAiQLWBbEhor5mwG1OPDHriufTAIwU2nsQ=",
      'kerunai': 'Gunung semanggol',
      // 'harga': 'Rm 300',
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/1341288649/photo/75mpix-panorama-of-beautiful-mount-ama-dablam-in-himalayas-nepal.webp?b=1&s=170667a&w=0&k=20&c=4NKz9veFo5-po92H0ZQ1FGoxMec7DaBPsaj9dZvp9rE=",
      'kerunai': 'Gunung Broga',
      // 'harga': 'RM200',
    },
    {
    'imageUrl':
          "https://media.istockphoto.com/id/1163279030/photo/aerial-panorama-of-rossfeld-mountain-panoramic-road-berchtesgaden-germany.webp?b=1&s=170667a&w=0&k=20&c=M-9eQfFFgRo0387ueunRMi5CKQvNRVo8586PViJteLM=",
      'kerunai': 'Gunung Berekeh',
      // 'harga': 'Harga 150',
    },
  ];
}

class Mount1 {
  List<Map<String, dynamic>> imagesWithText = [
    {
    'imageUrl':
          "https://media.istockphoto.com/id/1220337970/photo/mystic-moody-view-around-mount-ijen.jpg?s=612x612&w=0&k=20&c=zpVPYCacwP2DSS1gteXllr9StvUPGyBC9h8p1CgDVqM=",
      'kerunai': 'Gunung Pulai',
      // 'harga': 'RM40',
      "rating": "5",
      "Location": "kedah,Malaysia",
       "description":  "Gunung Pulai , a challenging yet rewarding peak at 2161m on the kedah -perak border. Dense vegetation adds a twist for seasoned hikers. Fun fact: Titiwangsa Range, home to G7, divides Peninsular Malaysia, featuring famous spots like Genting Highlands. Unveil the natural beauty of this 480km-long mountain range"

     
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/1455864269/photo/stunning-scenic-mountain-ranges-and-nature-area-in-montana-summertime.webp?b=1&s=170667a&w=0&k=20&c=Ebn8d5RHjdgJWl4B_LPy6XtgZFBlH2yTaO2pb1yq3DI=",
      'kerunai': 'Gunung Kerunai',
      // 'harga': 'Rm 400',
      "rating": "3",
      "Location": "perak, Malaysia",
       "description":  "Gunung Kerunai is a mountain located in Hulu Perak, Perak Darul Ridzuan, Malaysia, with an elevation of approximately 1,000 meters (3,300 feet)."
      
    },
    {
       'imageUrl':
          "https://www.goodnewsfromindonesia.id/wp-content/uploads/images/source/thomasbenmetan/DSCF1545.JPG",
      'kerunai': 'Gunung alai',
      // 'harga': 'RM40',
      "rating": "3",
      "Location": "Perak,Malaysia",
       "description":  "Gunung Alai is a mountain located in Hulu Perak, Perak Darul Ridzuan, Malaysia, with an elevation of approximately 2,000 meters (4,300 feet)"
     
    },
    {
    'imageUrl':
          "https://media.istockphoto.com/id/474267374/photo/reflections-on-a-lake.webp?b=1&s=170667a&w=0&k=20&c=8VDTbBQy-MAiQLWBbEhor5mwG1OPDHriufTAIwU2nsQ=",
      'kerunai': 'Gunung semanggol',
      // 'harga': 'Rm 300',
      "rating": "4",
      "Location": "Perak,Malaysia",
       "description":  "Gunung Semanggol is located in the Kerian district of the state of Perak. Gunung Semanggol is near Ulu Sepetang and Kampung Sera. Gunung Semanggol has an elevation of 390 meters. "
    },
    {
     'imageUrl':
          "https://media.istockphoto.com/id/1341288649/photo/75mpix-panorama-of-beautiful-mount-ama-dablam-in-himalayas-nepal.webp?b=1&s=170667a&w=0&k=20&c=4NKz9veFo5-po92H0ZQ1FGoxMec7DaBPsaj9dZvp9rE=",
      'kerunai': 'Gunung Broga',
      // 'harga': 'RM200',
      "rating": "8",
      "Location": "Selangor,Malaysia",
       "description":  "G7 Mounts Gunung Ulu Sepat, a challenging yet rewarding peak at 2161m on the Kelantan-Perak border. Dense vegetation adds a twist for seasoned hikers. Fun fact: Titiwangsa Range, home to G7, divides Peninsular Malaysia, featuring famous spots like Genting Highlands. Unveil the natural beauty of this 480km-long mountain range"
     
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/1163279030/photo/aerial-panorama-of-rossfeld-mountain-panoramic-road-berchtesgaden-germany.webp?b=1&s=170667a&w=0&k=20&c=M-9eQfFFgRo0387ueunRMi5CKQvNRVo8586PViJteLM=",
      'kerunai': 'Gunung Berekeh',
      // 'harga': 'Harga 150',
      "rating": "9",
      "Location": "Perak,Malaysia",
       "description":  "G7 Mounts Gunung Ulu Sepat, a challenging yet rewarding peak at 2161m on the Kelantan-Perak border. Dense vegetation adds a twist for seasoned hikers. Fun fact: Titiwangsa Range, home to G7, divides Peninsular Malaysia, featuring famous spots like Genting Highlands. Unveil the natural beauty of this 480km-long mountain range"
    
    },
  ];
}


class Waterfall12 {
  List<Map<String, dynamic>> imagesWithText = [
    {
     'imageUrl':
     "https://media.istockphoto.com/id/1453105033/photo/nauthusagil-waterfall-canyon-on-south-coast-iceland.jpg?s=612x612&w=is&k=20&c=QuBZoueKSxrk8JzoA3PnJpwJgiLqlGLkzR-KzMRvWKM=",
      'kerunai': 'Latar mendang',
      "rating": "4",
      "Location": "selangor ,Malaysia",
      "description":  "Lata Medang waterfall hike is an adventure through the lush Malaysian jungle. Starting near an Orang Asli village, the trail leads along an old gravel road, crossing the Pertak river on a sturdy suspension bridge. As you continue on the trail, the sound of the rushing Sungai Luit will keep you company. The hike takes you through several scenic stops, including the first campground and the small waterfall known as Lata Jebus"

     
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/108351629/photo/rainforest-waterfalls-hopetoun-falls-great-otway-np-victoria-australia.jpg?s=612x612&w=is&k=20&c=_XIGSf8mktye6K1TjPFMAp8gDmaT4JQuv9Qc2sjjKhM=",
      'kerunai': 'latar gapi',
      // 'harga': 'Rm 30',

      "rating": "3",
      "Location": "Skudai, Malaysia",
       "description":  "G7 Mounts Gunung Ulu Sepat, a challenging yet rewarding peak at 2161m on the Kelantan-Perak border. Dense vegetation adds a twist for seasoned hikers. Fun fact: Titiwangsa Range, home to G7, divides Peninsular Malaysia, featuring famous spots like Genting Highlands. Unveil the natural beauty of this 480km-long mountain range"
      
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/1447286216/photo/detian-waterfall-in-guangxi-china.webp?b=1&s=170667a&w=0&k=20&c=460ioerRynRMieTLz9h3lsaafDjiafb5sqWulPUKhkM=",
      'kerunai': 'Latar ledang ',
      // 'harga': 'Rm 50',
      "rating": "3",
      "Location": "Perak,Malaysia",
       "description":  "G7 Mounts Gunung Ulu Sepat, a challenging yet rewarding peak at 2161m on the Kelantan-Perak border. Dense vegetation adds a twist for seasoned hikers. Fun fact: Titiwangsa Range, home to G7, divides Peninsular Malaysia, featuring famous spots like Genting Highlands. Unveil the natural beauty of this 480km-long mountain range"
     
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/177204154/photo/mae-ya-waterfall-doi-inthanon-thailand.webp?b=1&s=170667a&w=0&k=20&c=66H4oFCBQNh4esyw2ozZBnSz4xWNkJ1Acvde80R5a34=",
      'kerunai': 'latar hijau',
      // 'harga': 'RM40',
      "rating": "4",
      "Location": "Pahang,Malaysia",
       "description":  "G7 Mounts Gunung Ulu Sepat, a challenging yet rewarding peak at 2161m on the Kelantan-Perak border. Dense vegetation adds a twist for seasoned hikers. Fun fact: Titiwangsa Range, home to G7, divides Peninsular Malaysia, featuring famous spots like Genting Highlands. Unveil the natural beauty of this 480km-long mountain range"
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/887549988/photo/traveler-near-waterfall.webp?b=1&s=170667a&w=0&k=20&c=uP-eEbZ7ZM2q12le2lQrMPKj5kb-HxuT3frhkMMsKf0=",
      'kerunai': 'latar penyel',
      // 'harga': 'Harga 40',
      "rating": "8",
      "Location": "Selangor,Malaysia",
       "description":  "This forest area in Sungai Siput is one of the least known ‘hidden gems’ in Perak. Located about 50km away Sungai Siput town, the 60m high waterfall is not mistakenly the hidden one as visitors need to hike about 15-20 minutes to the waterfall from the parking area. But the hike is pretty easy and well-maintained by the Orang Asli community there. There is a village of Orang Asli community here known as Pos Yum. Here are the usual spot for hikers who hiking at Bukit Berekeh."
     
    },
    {
     'imageUrl':
          "https://media.istockphoto.com/id/184684327/photo/seven-wells-waterfall.webp?b=1&s=170667a&w=0&k=20&c=_8Y2lOaOsbJm0o9alDjozhWd8uHfltAL2aJe_4kIxAU=",
      'kerunai': 'Batu Bertenggek',
      // 'harga': 'Harga 50',
      "rating": "5",
      "Location": "Selangor,Malaysia",
       "description":  "Batu Bertenggek Falls is a beautiful natural wonder that features a jagged slab of rock that sits perched lopsidedly at its base, giving it its name. To reach the falls, you will need to walk along a tarmac road, passing by privately-owned farms and small resorts on either side of the road. As you continue along the jungle trail, you will eventually reach Batu Bertenggek Falls, which drops an impressive 30 meters. However, the pool just above the cascades is deep with a strong current, so it's best avoided."
    
      },
  ];
}


  class waterfall {
  List<Map<String, dynamic>> imagesWithText = [
    {
      'imageUrl':
          "https://media.istockphoto.com/id/1453105033/photo/nauthusagil-waterfall-canyon-on-south-coast-iceland.jpg?s=612x612&w=is&k=20&c=QuBZoueKSxrk8JzoA3PnJpwJgiLqlGLkzR-KzMRvWKM=",
      'kerunai': 'Latar mendang',
      // 'harga': 'Rm 20',
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/108351629/photo/rainforest-waterfalls-hopetoun-falls-great-otway-np-victoria-australia.jpg?s=612x612&w=is&k=20&c=_XIGSf8mktye6K1TjPFMAp8gDmaT4JQuv9Qc2sjjKhM=",
      'kerunai': 'latar gapi',
      // 'harga': 'Rm 30',
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/1447286216/photo/detian-waterfall-in-guangxi-china.webp?b=1&s=170667a&w=0&k=20&c=460ioerRynRMieTLz9h3lsaafDjiafb5sqWulPUKhkM=",
      'kerunai': 'Latar ledang ',
      // 'harga': 'Rm 50',
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/177204154/photo/mae-ya-waterfall-doi-inthanon-thailand.webp?b=1&s=170667a&w=0&k=20&c=66H4oFCBQNh4esyw2ozZBnSz4xWNkJ1Acvde80R5a34=",
      'kerunai': 'latar hijau',
      // 'harga': 'RM40',
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/887549988/photo/traveler-near-waterfall.webp?b=1&s=170667a&w=0&k=20&c=uP-eEbZ7ZM2q12le2lQrMPKj5kb-HxuT3frhkMMsKf0=",
      'kerunai': 'latar dua',
      // 'harga': 'Harga 40',
    },
    {
      'imageUrl':
          "https://media.istockphoto.com/id/184684327/photo/seven-wells-waterfall.webp?b=1&s=170667a&w=0&k=20&c=_8Y2lOaOsbJm0o9alDjozhWd8uHfltAL2aJe_4kIxAU=",
      'kerunai': 'Batu bertenggek',
      // 'harga': 'Harga 50',
    },
  ];
}



