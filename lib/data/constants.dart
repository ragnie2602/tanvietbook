enum UIState {
  init,
  loading,
  loaded,
  success,
  error,
  end;
}

class CollaboratorState {
  static const String stateNull = "null";
  static const String stateNew = "NEW";
  static const String stateMemberApproved = "member_approved";
  static const String stateMemberRejected = "member_rejected";
  static const String stateApproved = "APPROVED"; //stt admin vừa mới chấp nhận
  static const String stateRejected = "REJECTED"; //stt admin vừa mới từ chối
}

class SharedPreferenceKey {
  static const String xLicenseKey = "xLicenseKey";
  static const String idToken = "idToken";
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String username = "username";
  static const String password = "password";
  static const String rememberMe = "rememberMe";
  static const String userId = "userId";
  static const String userRole = "userRole";
  static const String memberId = "memberId";
  static const String isRegisterFCMToken = "IsRegisterFCMToken";
}

class BaseInfoType {
  static const String personalInformation = "BasicInfor";
  static const String highLight = "HighLight";
  static const String contact = "Contact";
  static const String organization = "Organization";
  static const String additionalPath = "AdditionalPath";
}

class BaseInfoIntroduction {
  static const String personalInformation = "Ngày sinh, giới tính, địa chỉ,...";
  static const String highLight = "HighLight";
  static const String contact = "Điện thoại, tin nhắn, email, zalo,...";
  static const String organization =
      "Chức vụ, phòng ban, tổ chức, lĩnh vực,...";
  static const String additionalPath = "Website, Youtube,...";
}

abstract class UserRole {
  static const int user = 0; //: User
  static const int collaborator = 1; //: CTV
  static const int sale = 2; //: Sale
  static const int custom = 3; //: Tuỳ chọn
  static const int all = 4; //: Tất cả
}

abstract class OrderStatus {
  static const int pending = 1;
  static const int packaging = 2;
  static const int delivering = 3;
  static const int delivered = 4;
  static const int canceled = 5;
  static const int refunded = 6;
}

abstract class OrderStatusStr {
  static const String pending = "Chờ xác nhận";
  static const String packaging = "Chờ lấy hàng";
  static const String delivering = "Đang giao";
  static const String delivered = "Đã giao";
  static const String canceled = "Đã huỷ";
  static const String refunded = "Trả hàng";
}

abstract class EventRegisterStatus {
  static const int noResponse = 0;
  static const int refuse = 1;
  static const int interested = 2;
  static const int willJoin = 3;
}

abstract class EventRegisterStatusString {
  static const String noResponse = 'Chưa phản hồi';
  static const String refuse = 'Từ chối';
  static const String interested = 'Quan tâm';
  static const String willJoin = "Tham gia";
}

enum AppInputType {
  dropDown,
  dropDownCheckbox,
  datePicker,
  popUpShow,
  timePicker,
  location
}

enum AppStringFormatType {
  sequence,
  title,
  allCaps,
  allLowerCase,
}

enum LandingPageViewType {
  add,
  edit,
  editForButtonShow,
  view,
}

enum LandingPageItemViewType {
  forLandingPageView,
  forLandingPageEdit,
  forPostView,
  forButtonShow
}

enum ViewType {
  viewOwn,
  viewMember,
  viewAsGuest,
}

enum UriType { phone, website, email, zalo, sms }

enum DialogType {
  alert,
  datePicker,
}

enum ImageCropStyle { circle, rect, square }

enum ImageType {
  none,
  avatar,
  cover,
  square,
}

enum ChangePositionType { up, down, upToTop, downToBottom }

abstract class CategoryType {
  static const String post = "Post";
  static const String landingPage = "LandingPage";
  static const String all = "all";
}

abstract class CategoryContentType {
  static const String content = "Nội dung";
  static const String images = "Hình ảnh";
  static const String link = "Video";
  static const String callAction = "Kêu gọi hành động";
  static const String button = "Nút bấm";
  static const List<String> list = [images, content, link, callAction, button];
}

enum AppPlatform { mobile, tablet, android, ios, macos, web }

const orderStatus = [
  'Đang chờ',
  'Đang xử lý',
  'Đang vận chuyển',
  'Đã hoàn thành',
  'Đã huỷ'
];

abstract class PaymentMethod {
  static const int cash = 0;
  static const int internetBanking = 1;
}

abstract class OrderMethod {
  static const int forMe = 0;
  static const int forCustomer = 1;
}

abstract class TransportMethod {
  static const int warehouse = 0;
  static const int viettelPost = 1;
}

abstract class ShippingMethod {
  static const int inventory = 0;
  static const int viettelPost = 1;
}

abstract class PaymentMethodStr {
  static const String cash = 'Thanh toán khi nhận hàng';
  static const String internetBanking = 'Chuyển khoản';
}

abstract class PaymentStatus {
  static const int notPaid = 1;
  static const int paid = 2;
  static const int canceled = 3;
}

abstract class ProductStatus {
  static const int outOfStock = 2; // het hang
  static const int outOfProduct = 3; // chua co hang
}

abstract class PaymentStatusStr {
  static const String notPaid = 'Chưa thanh toán';
  static const String paid = 'Đã thanh toán';
  static const String canceled = 'Đã huỷ';
}

abstract class VoucherType {
  static const int money = 0;
  static const int percent = 1;
  static const int shipping = 2;
}

abstract class VoucherStatus {
  static const String success = "1";
  static const String notExist = "-1";
  static const String deactive = "-2";
  static const String notMeetMinimumValue = "-3";
  static const String outOfVoucher = "-4";
  static const String notStarted = "-5";
  static const String expired = "-6";
  static const String endOfUse = "-7";

  // 1       Thành công -> SCD9 -> sửa tài liệu
// -1      Không tồn taị -> IEM3 -> sửa tài liệu
// -2      Không mở (deactive) -> IEM 4 -> sửa tài liệu
// -3      Nhỏ hơn phí tối thiểu đc giảm giá -> IEM 7 -> sửa tai liệu
// -4      Hết mã -> IEM 8 -> sửa tài liệu
// -5      Chưa đến ngày mở mã -> IEM 2 -> sửa tl
// -6      Hết hạn -> IEM 9 -> sửa tài liệu
// -7      Người dùng đã sử dụng mã không dùng lại được -> IEM 8
}

abstract class AddressStatus {
  static const int normal = 0;
  static const int main = 1;
}

class LandingPageCallActionOptions {
  static const String fullName = 'Họ tên';
  static const String email = 'Email';
  static const String phone = 'Số điện thoại';
  static const String address = 'Địa chỉ';
  static const String birthday = 'Sinh nhật';
  static const String note = 'Lời nhắn';
  static const List<String> list = [
    fullName,
    email,
    phone,
    address,
    birthday,
    note
  ];
}

class LandingPageButtonFunction {
  static const String scrollToCTA = 'Kéo đến kêu gọi hành động';
  static const String openDialog = 'Mở ra hộp thông tin';
  static const String additionalLink = 'Liên kết bổ sung';
  static const List<String> list = [scrollToCTA, openDialog, additionalLink];
}
