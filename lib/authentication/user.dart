import 'package:relis/globals.dart';

Map<String, dynamic>? user;

// Map<String, dynamic> user0 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-0",
//   "lastName" : "User-0",
//   "emailId" : "user0user0@relix.app",
//   "password" : "user0user0@relix.app",
//   "imageURL" : "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], book10["id"],],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"], book10["id"],],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], book10["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user1 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-1",
//   "lastName" : "User-1",
//   "emailId" : "user1user1@relix.app",
//   "password" : "user1user1@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"]],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], ],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user2 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-2",
//   "lastName" : "User-2",
//   "emailId" : "user2user2@relix.app",
//   "password" : "user2user2@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"]],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user3 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-3",
//   "lastName" : "User-3",
//   "emailId" : "user3user3@relix.app",
//   "password" : "user3user3@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"]],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user4 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-4",
//   "lastName" : "User-4",
//   "emailId" : "user4user4@relix.app",
//   "password" : "user4user4@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"]],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user5 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-5",
//   "lastName" : "User-5",
//   "emailId" : "user5user5@relix.app",
//   "password" : "user5user5@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"]],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user6 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-6",
//   "lastName" : "User-6",
//   "emailId" : "user6user6@relix.app",
//   "password" : "user6user6@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"]],
//   "bookHistory" : [],
//   "personalBooks" : [],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user7 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-7",
//   "lastName" : "User-7",
//   "emailId" : "user7user7@relix.app",
//   "password" : "user7user7@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"], book10["id"],],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user8 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-8",
//   "lastName" : "User-8",
//   "emailId" : "user8user8@relix.app",
//   "password" : "user8user8@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], book10["id"],],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"], book10["id"],],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], book10["id"]],
//   "booksRented" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "rentedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//       "dueOn": "${DateTime.now().add(Duration(days: 5))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

// Map<String, dynamic> user9 = {
//   "userType" : "admin", // normal, admin, etc.
//   "firstName" : "User-9",
//   "lastName" : "User-9",
//   "emailId" : "user9user9@relix.app",
//   "password" : "user9user9@relix.app",
//   "imageURL" : null,
//   "userStatus" : "",
//   "favouriteBook" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], book10["id"],],
//   "wishListBook" : [],
//   "recommendedBook" : [book1["id"], book2["id"], book3["id"], book5["id"], book6["id"], book8["id"], book9["id"], book10["id"],],
//   "bookHistory" : [],
//   "personalBooks" : [book1["id"], book2["id"], book3["id"], book4["id"], book5["id"], book6["id"], book7["id"], book8["id"], book9["id"], book10["id"]],
//   "booksRented" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksBought" : {
//     book1["id"] : {
//       "id" : book1["id"],
//       "purchasedOn": "${DateTime.now().subtract(Duration(days: 3))}",
//     }
//     // "bookId" : "bookRentedTimeStamp",
//   },
//   "booksRead" : {
//     // "bookId" : "bookRentedTimeStamp",
//   },
// };

Map<String, dynamic> user10 = {
  "userType" : "admin", // normal, admin, etc.
  "firstName" : "User-10",
  "lastName" : "User-10",
  "emailId" : "user10user10@relix.app",
  "password" : "user10user10@relix.app",
  "imageURL" : null,
  "userStatus" : "",
  "favouriteBook" : [],
  "wishListBook" : [],
  "recommendedBook" : [],
  "bookHistory" : [],
  "personalBooks" : [],
  "booksRented" : {
    // "bookId" : "bookRentedTimeStamp",
  },
  "booksBought" : {
    // "bookId" : "bookRentedTimeStamp",
  },
  "booksRead" : {
    // "bookId" : "bookRentedTimeStamp",
  },
};

Map<String, dynamic> user11 = {
  "userType" : "admin", // normal, admin, etc.
  "firstName" : "User-11",
  "lastName" : "User-11",
  "emailId" : "user11user11@relix.app",
  "password" : "user11user11@relix.app",
  "imageURL" : null,
  "userStatus" : "",
  "favouriteBook" : [],
  "wishListBook" : [],
  "recommendedBook" : [],
  "bookHistory" : [],
  "personalBooks" : [],
  "booksRented" : {
    // "bookId" : "bookRentedTimeStamp",
  },
  "booksBought" : {
    // "bookId" : "bookRentedTimeStamp",
  },
  "booksRead" : {
    // "bookId" : "bookRentedTimeStamp",
  },
};

Map<String, dynamic> user12 = {
  "userType" : "admin", // normal, admin, etc.
  "firstName" : "User-12",
  "lastName" : "User-12",
  "emailId" : "user12user12@relix.app",
  "password" : "user12user12@relix.app",
  "imageURL" : null,
  "userStatus" : "",
  "favouriteBook" : [],
  "wishListBook" : [],
  "recommendedBook" : [],
  "bookHistory" : [],
  "personalBooks" : [],
  "booksRented" : {
    // "bookId" : "bookRentedTimeStamp",
  },
  "booksBought" : {
    // "bookId" : "bookRentedTimeStamp",
  },
  "booksRead" : {
    // "bookId" : "bookRentedTimeStamp",
  },
};

var globalUser = [user10, user11, user12];

var globalUserMap = {};

void loadGlobalUserMap() {
  for(var gu in globalUser) {
    globalUserMap[gu["emailId"]] = gu;
  }
}

var userType = ["admin", "normal"];






