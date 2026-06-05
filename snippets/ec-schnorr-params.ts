// Tham số hệ thống EC-Schnorr -- cố định suốt vòng đời ứng dụng
const CURVE = "secp256k1";
const SCALAR_BYTES = 32; // kích thước scalar (bytes)
const POINT_BYTES = 33; // kích thước point nén (bytes)
// n  -- bậc của nhóm 256-bit (order), xác định bởi secp256k1
// G  -- điểm sinh chuẩn (generator point) của đường cong
