import 'package:farm_system/storage.dart';
import 'package:flutter/material.dart';

class DashboardRepo extends ChangeNotifier {
  String userName;
  String name;
  String userProfilePic;
  String userId;

  fetchUserDetail() async {
    print('pppppppppppppppppppppppppppppppppppppp');
    userName = await StorageService.getUserName();
    name = await StorageService.getName();
    userProfilePic = await StorageService.getUserProfile();
    userId = await StorageService.getUserId();
    notifyListeners();
  }
}
