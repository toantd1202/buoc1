
# 1.Tổng quan về Ansible
# 2.Tìm hiểu và viết tài liệu Fluentd
# Tổng quan Fluentd

**NOTE**:

* Tạo Thư mục Fluentd ở repo Training cá nhân (<Nguyen Van A>/<Fluentd>).
* Có 1 file markdown với cấu trúc như sau (TOC).
* Các phần Tìm hiểu plugins và Config section.
  * Các tham số không cần viết hết, giải thích.
  * Tổng quan plugin đấy làm gì, xử lý tác động như thế nào đến event log.
  * Có thử nghiệm, link đến cấu hình thử nghiệm.
* Mọi cấu hình thử nghiệm + docker-compose lưu trữ ở Thư mục Fluentd của repo Training cá nhân nhé.

- [ ] Fluentd là gì?
- [ ] Kiến trúc tổng quan của Fluentd
- [ ] Cài đặt Fluentd với Docker
- [ ] Cấu hình của Fluentd
  - [ ] Cấu trúc thư mục cấu hình cơ bản
  - [ ] Routing event
  - [ ] Config: Các tham số thông dụng
  - [ ] Config: Parse Section
  - [ ] Config: Buffer Section
  - [ ] Config: Format Section
- [ ] Tìm hiểu về Input Plugins cơ bản.
  - [ ] Tổng quan
  - [ ] in_tail
  - [ ] in_syslog
- [ ] Tìm hiểu về Output Plugins cơ bản.
  - [ ] Tổng quan
  - [ ] out_file
  - [ ] out_copy
  - [ ] out_elasticsearch
- [ ] Tìm hiểu về Filter Plugins cơ bản.
  - [ ] Tổng quan
  - [ ] filter_record_transformer
  - [ ] filter_grep
  - [ ] filter_parser
- [ ] Tìm hiểu về Parser Plugins cơ bản
  - [ ] Tổng quan
  - [ ] parser_regexp
  - [ ] parser_syslog
- [ ] Tìm hiểu về Buffer Plugins
  - [ ] Tổng quan (Phần này quan trọng vì cần để tuning performace sau này)
  - [ ] buf_memory
  - [ ] buf_file
- [ ] Trouble Shooting
- [ ] Tối ưu hóa hiệu năng
