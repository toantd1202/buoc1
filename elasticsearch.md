# elasticsearch
Plugin `out_elaticsearch`, ghi các bản ghi vào Elaticsearch. Theo mặc định, nó tạo các bản ghi bằng thao tác ghi số lượng lớn. Điều này có nghĩa là khi bạn lần đầu tiên nhập bản ghi bằng plugin, không có bản ghi nào được tạo ngay lập tức.

Bản ghi sẽ được tạo khi điều kiện `chunk_keys` được đáp ứng. Để thay đổi tần số đầu ra, vui lòng chỉ định `time` trong `chunk_keys` và chỉ định giá trị  `timekey` trong conf.

## Parameters
**@type**
Tùy chọn luôn là `elasticsearch`
**host(option)**

