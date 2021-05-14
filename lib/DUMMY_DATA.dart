import './providers/meal.dart';
import './providers/canteen.dart';

List<Meal> canteenMealList = [
  Meal(
    "m1",
    "Samosa",
    14,
    "https://upload.wikimedia.org/wikipedia/commons/c/cb/Samosachutney.jpg",
  ),
  Meal(
    "m2",
    "Kachori",
    14,
    "https://i.ndtvimg.com/i/2017-11/kachori_650x400_51510318031.jpg",
  ),
  Meal(
    "m3",
    "Paneer Kulcha",
    65,
    "https://s3-ap-south-1.amazonaws.com/betterbutterbucket-silver/anjali-valecha20181126182243587.jpg",
    isAvailable: false,
  ),
  Meal(
    "m4",
    "Chole Bhature",
    100,
    "https://www.cookwithkushi.com/wp-content/uploads/2021/01/IMG_7765.jpg",
  ),
  Meal(
    "m5",
    "Pao Bhaji",
    100,
    "https://www.indianhealthyrecipes.com/wp-content/uploads/2014/10/pav-bhaji-recipe-500x500.jpg",
  ),
  Meal(
    "m6",
    "Idli Sambhar",
    55,
    "https://www.vegrecipesofindia.com/wp-content/uploads/2014/05/idli-sambar-1-500x500.jpg",
  ),
  Meal(
    "m7",
    "Veg Burger",
    60,
    "https://www.vegrecipesofindia.com/wp-content/uploads/2018/12/veg-burger-recipe-1.jpg",
  ),
  Meal(
    "m8",
    "Cheese Burger",
    90,
    "https://i.pinimg.com/originals/8b/61/11/8b611136ead0d4c247f0fef92925f284.jpg",
  ),
  Meal(
    "m9",
    "Sandwich",
    25,
    "https://static.toiimg.com/thumb/54714340.cms?width=1200&height=900",
  ),
  Meal(
    "m10",
    "Vada Pav",
    40,
    "https://www.indianhealthyrecipes.com/wp-content/uploads/2019/10/vada-pav-recipe.jpg",
  ),
  Meal(
    "m11",
    "Kadi Chawal",
    100,
    "https://www.rakshikajain.com/wp-content/uploads/2019/10/img_05751-1024x683.jpg",
  ),
  Meal(
    "m12",
    "Chole Chawal",
    100,
    "https://i.pinimg.com/originals/ba/15/b9/ba15b93d0e2923f0a71247592ea6667c.jpg",
  ),
  Meal(
    "m13",
    "Veg Thali",
    200,
    "https://img-global.cpcdn.com/recipes/ce884d070a8abf57/1200x630cq70/photo.jpg",
  ),
];
List<Meal> micMacMeals = [
  Meal(
    "m1",
    "Aloo Paratha",
    68,
    "https://static.toiimg.com/thumb/53109843.cms?imgsize=244340&width=800&height=800",
  ),
  Meal(
    "m2",
    "Onion Paratha",
    68,
    "https://i.ytimg.com/vi/8HWNsQ0S8Og/maxresdefault.jpg",
  ),
  Meal(
    "m3",
    "Aloo Pyaaz Paratha",
    68,
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqMFKsZu4CALkMWx_lKuSqHG9tJVazSQEcZA&usqp=CAU",
  ),
  Meal(
    "m4",
    "Gobhi Paratha",
    74,
    "https://m.tarladalal.com/members/9306/big/big_gobi_paratha,__punjabi_gobi_paratha-14554.jpg",
  ),
  Meal(
    "m5",
    "Paneer Paratha",
    80,
    "https://cdn.shortpixel.ai/client/q_glossy,ret_img,w_800,h_1200/https://culinaryshades.com/wp-content/uploads/2021/01/paneer-paratha-v3-scaled-e1610839542513.jpeg",
  ),
  Meal(
    "m6",
    "Mooli Paratha",
    70,
    "https://www.cubesnjuliennes.com/wp-content/uploads/2019/07/Punjabi-Mooli-Ka-Paratha-Recipe.jpg",
  ),
  Meal(
    "m7",
    "Mix Paratha",
    74,
    "https://www.indianhealthyrecipes.com/wp-content/uploads/2020/01/mix-veg-paratha.jpg",
  ),
  Meal(
    "m8",
    "Gajar Paratha",
    88,
    "https://www.vegrecipesofindia.com/wp-content/uploads/2017/01/carrot-paratha-recipe-35.jpg",
  ),
  Meal(
    "m9",
    "Palak Paratha",
    78,
    "https://www.indianhealthyrecipes.com/wp-content/uploads/2015/07/palak-paratha.jpg",
  ),
  Meal(
    "m10",
    "Soya Keema Paratha",
    78,
    "http://www.premascook.com/wp-content/uploads/2015/09/Soya-keema-Paratha.jpg",
  ),
];
List<Meal> hpmcMeals = [
  Meal(
    "m1",
    "Apple Juice",
    30,
    "https://brooklynfarmgirl.com/wp-content/uploads/2019/02/Apple-Juice-Featured-Image.jpg",
    typesPrices: {
      "Small": 30,
      "Medium": 35,
      "Large": 40,
    },
  ),
  Meal(
    "m2",
    "Pomegranate Juice",
    35,
    "https://cdn-prod.medicalnewstoday.com/content/images/articles/318/318385/halves-pomegranate-with-seeds-and-pomegranate-juice-on-marbled-surface.jpg",
    typesPrices: {
      "Small": 35,
      "Medium": 40,
      "Large": 45,
    },
  ),
  Meal(
    "m3",
    "Strawberry Juice",
    30,
    "https://lh3.googleusercontent.com/fKxyH2l-7UMek_8UHU0PpXH3vbe5JPV421TZsLQcfpde_Jjfppqip6Ul0MjdKhgQBu9FmP-VdWieWBRN_5OG=w1280-h960-c-rj-v1-e365",
    typesPrices: {
      "Small": 30,
      "Medium": 35,
      "Large": 40,
    },
  ),
  Meal(
    "m4",
    "Avocado Juice",
    30,
    "https://www.thespruceeats.com/thmb/1TvYgXqM3MFgxb5qPbDy4BMs3Bs=/2012x1490/filters:fill(auto,1)/GettyImages-511024538-5afef110875db9003675c624.jpg",
    typesPrices: {
      "Small": 30,
      "Medium": 35,
      "Large": 40,
    },
  ),
  Meal(
    "m5",
    "Melon Juice",
    25,
    "https://5.imimg.com/data5/DT/PV/MY-28707171/magic-musk-melon-juice-500x500.png",
    typesPrices: {
      "Small": 25,
      "Medium": 30,
      "Large": 35,
    },
  ),
  Meal(
    "m6",
    "Banana Juice",
    20,
    "https://5.imimg.com/data5/DT/PV/MY-28707171/magic-musk-melon-juice-500x500.png",
    typesPrices: {
      "Small": 20,
      "Medium": 25,
      "Large": 30,
    },
  ),
  Meal(
    "m7",
    "Mix Juice",
    30,
    "https://4.imimg.com/data4/XB/FG/MY-31657999/mix-fruit-juice-500x500.jpg",
    typesPrices: {
      "Small": 30,
      "Medium": 35,
      "Large": 40,
    },
  ),
  Meal(
    "m8",
    "Mosambi Juice",
    25,
    "https://i.ndtvimg.com/i/2016-11/mosambi_620x350_61479372568.jpg",
    typesPrices: {
      "Small": 25,
      "Medium": 30,
      "Large": 35,
    },
  ),
  Meal(
    "m9",
    "Watermelon Juice",
    20,
    "https://www.thespruceeats.com/thmb/btkemOkvdGKQLPy2YAvRbDfH4HQ=/3000x2000/filters:fill(auto,1)/watermelon-juice-recipe-to-burn-fat-2078407-hero-03-5754d230d6304eed951d94968c6173b8.jpg",
    typesPrices: {
      "Small": 20,
      "Medium": 25,
      "Large": 30,
    },
  ),
  Meal(
    "m10",
    "Mango Juice",
    30,
    "https://static.toiimg.com/thumb/59809728.cms?imgsize=78258&width=800&height=800",
    typesPrices: {
      "Small": 30,
      "Medium": 35,
      "Large": 40,
    },
  ),
  Meal(
    "m11",
    "Orange Juice",
    25,
    "https://www.alphafoodie.com/wp-content/uploads/2020/11/Orange-Juice-1-of-1.jpeg",
    typesPrices: {
      "Small": 25,
      "Medium": 30,
      "Large": 35,
    },
  ),
  Meal(
    "m12",
    "Grape Juice",
    20,
    "https://4.imimg.com/data4/VT/LQ/MY-31657999/grape-juice-500x500.jpg",
    typesPrices: {
      "Small": 20,
      "Medium": 25,
      "Large": 30,
    },
  ),
  Meal(
    "m13",
    "Pineapple Juice",
    20,
    "https://5.imimg.com/data5/LT/XB/MY-28787720/pineapple-drink-500x500.jpg",
    typesPrices: {
      "Small": 20,
      "Medium": 25,
      "Large": 30,
    },
  ),
];
List<Meal> nescafeMeals = [
  Meal(
    "m1",
    "Coffee Regular",
    30,
    "https://media3.s-nbcnews.com/j/newscms/2019_33/2203981/171026-better-coffee-boost-se-329p_67dfb6820f7d3898b5486975903c2e51.fit-1240w.jpg",
    typesPrices: {
      "Small": 30,
      "Medium": 35,
      "Large": 40,
    },
  ),
  Meal(
    "m2",
    "Cappuccino",
    40,
    "https://i.pinimg.com/736x/f4/98/9a/f4989acca14ba58f116b49fde0d4e0b0.jpg",
    typesPrices: {
      "Small": 40,
      "Medium": 45,
      "Large": 50,
    },
  ),
  Meal(
    "m3",
    "Cappuccino Twister",
    40,
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoW_s4EndZ2R6A7J66uBQBCOFp5Gt_MOAQew&usqp=CAU",
    typesPrices: {
      "Small": 40,
      "Medium": 45,
      "Large": 50,
    },
  ),
  Meal(
    "m4",
    "Espresso",
    20,
    "https://static.scientificamerican.com/sciam/cache/file/7C0BADB7-D030-4E4E-BE715FB20458C51E_source.jpg?w=590&h=800&533ACFE5-6F68-4434-B0595E60892B668A",
    typesPrices: {
      "Small": 20,
      "Medium": 25,
      "Large": 30,
    },
  ),
  Meal(
    "m5",
    "Cafe Mocha",
    50,
    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Mocha_coffee.jpg",
    typesPrices: {
      "Small": 50,
      "Medium": 55,
      "Large": 60,
    },
  ),
  Meal(
    "m6",
    "Cafe Latte",
    35,
    "https://upload.wikimedia.org/wikipedia/commons/c/c6/Latte_art_3.jpg",
    typesPrices: {
      "Small": 35,
      "Medium": 40,
      "Large": 45,
    },
  ),
  Meal(
    "m7",
    "Chocodelite",
    50,
    "https://i1.wp.com/gatherforbread.com/wp-content/uploads/2014/10/Dark-Chocolate-Mocha-Square.jpg?fit=1000%2C1000&ssl=1",
    typesPrices: {
      "Small": 50,
      "Medium": 55,
      "Large": 60,
    },
  ),
  Meal(
    "m8",
    "Nescafe Ice",
    50,
    "https://www.nestleprofessional.us/sites/g/files/gfb131/f/styles/recipe/public/media/instant-iced-coffee-nestle-professional-food-service-430x320.jpg?itok=lKyuuT8Y",
    typesPrices: {
      "Small": 50,
      "Medium": 55,
      "Large": 60,
    },
  ),
  Meal(
    "m10",
    "Iced Tea",
    40,
    "https://www.ohhowcivilized.com/wp-content/uploads/2019/05/0519-iced-tea-8-1.jpg",
    typesPrices: {
      "Small": 40,
      "Medium": 45,
      "Large": 50,
    },
  ),
  Meal(
    "m11",
    "Nescafe Ice Twister",
    60,
    "https://i.pinimg.com/originals/44/24/d7/4424d779477a8b49ae047aea79b5f4c1.jpg",
    typesPrices: {
      "Small": 60,
      "Medium": 65,
      "Large": 70,
    },
  ),
  Meal(
    "m12",
    "Iced Tea Twister",
    50,
    "https://www.vegrecipesofindia.com/wp-content/uploads/2017/05/lemon-iced-tea-recipe-1.jpg",
    typesPrices: {
      "Small": 50,
      "Medium": 55,
      "Large": 60,
    },
  ),
];

List<Canteen> canteenList = [
  Canteen(id: "c1", canteenName: "Canteen", meals: canteenMealList), //13
  Canteen(id: "c2", canteenName: "Mic Mac", meals: micMacMeals), //10
  Canteen(id: "c3", canteenName: "HPMC", meals: hpmcMeals), //13
  Canteen(id: "c4", canteenName: "Nescafe", meals: nescafeMeals), //12
];

Map<String, List<String>> previousOrders = {
  "c1": ["m1", "m3", "m5", "m6", "m11", "m12"],
  "c2": ["m2", "m4", "m5"],
  "c3": ["m1", "m2", "m4", "m8", "m10", "m13"],
  "c4": [],
};
