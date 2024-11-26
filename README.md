# note_app

A new Flutter project.

## Getting Started

Xin chào, tôi là Nguyễn Văn Lâm - một người chưa biết gì về lập trình.
Và đây là dự án Flutter đầu tiên của tôi sau khi theo học khóa Flutter tại Techmaster.
Dự án có tên Note App, dùng để ghi nhớ những kế hoạch,
công việc cần làm trong tương lai.
Note App có những chức năng: 
- Tạo bảng để thêm mới, sửa, xóa... ghi chú,
- Đánh dấu ngày tháng cho ghi chú,
- Đánh dấu ghi chú đã được thực hiện,
- Chia sẻ ghi chú cho các nền tảng bên ngoài khác,
...
Dự án được triển khai:
- Observable để lắng nghe sự thay đổi của dữ liệu,
- Dữ liệu được chia thành các tầng:
+ Data - collection đại diện cho thông tin lưu trữ database('ISAR'),
+ Entity - các Model được sử dụng để thực hiện việc show data và logic,
+ Repository có vai trò quản lý việc đọc, ghi dữ liệu database presentation,
+ Bloc dùng để quản lý trạng thái màn hình và các logic của App...

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
