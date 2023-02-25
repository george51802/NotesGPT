import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'addFriends': 'Add Friends',
          'signOut': 'Sign Out',
          'editProfile': 'Edit Profile',
          'changeLanguage': 'Change Language'
        },
        'hi_IN': {
          'addFriends': 'मित्र बनाओ',
          'signOut': 'साइन आउट',
          'editProfile': 'प्रोफ़ाइल संपादित करें',
          'changeLanguage': 'भाषा बदलें'
        },
        'es_SP': {
          'addFriends': 'Añade amigos',
          'signOut': 'Desconectar',
          'editProfile': 'Editar perfil',
          'changeLanguage': 'Cambiar idioma'
        }
      };
}
