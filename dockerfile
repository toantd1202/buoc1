	Docker: sử dụng chung kernel với HostOS thay vì phải tạo ra các GuestOS khác nhau, vì vậy tốc độ được cải thiện rất nhiều so với hypervisors (rõ ràng nhất là khi chạy nhiều containers so với chạy nhiều máy ảo), từ đó mang lại tính khả thi cao cho những dự án cần sự mở rộng nhanh.
	Hypervisors: thực hiện ảo hỏa nằm ở tầng Hardware (phần cứng), tức là mô phỏng phần cứng và chạy những OS con trên phần cứng đó. Như trong hình ảnh trên, Hypervisors có thêm một Guest OS cho nên sẽ tốn tài nguyên hơn và làm chậm máy thật khi sử dụng. Bạn nào hồi đi học có sử dụng VMWare chắc cũng biết, bật được con máy ảo VMWare lên đã khổ, dùng nó còn khổ hơn.
	CE (Community Edition): phù hợp cho đối tượng là các developer hay những nhóm nhỏ muốn bắt đầu trải nghiệm Docker.
	EE (Enterprise Edition): là phiên bản Docker CE có chứng nhận đối với một vài hệ thống và được hỗ trợ bởi các doanh nghiệp lớn như IBM, Microsoft, Alibaba, Canonical, Docker Inc, ... 
	Dockerfile:
Dockerfile là một tài liệu dạng văn bản chứa tất cả các câu lệnh mà người dùng muốn gọi đến ở trong giao diện command-line. Và từ Dockerfile này, chỉ với 1 câu lệnh docker build là Docker sẽ tự động xây dựng nên một Docker image (kéo xuống dưới sẽ biết nó là gì).
+ các thành phần có trong docker file
/FROM: khai báo xem image sắp khởi tạo sẽ được xây dừng từ image gốc nào. Các image có thể lấy được từ Docker Hub.
cú pháp: FROM <image>[:<tag>] [AS <name>]
/LABEL: là một/nhiều cặp key-value để thêm metadata vào cho image ví dụ như là version, description, ...
cú pháp: LABEL <key>=<value> <key>=<value> <key>=<value>
/RUN: ở đây sẽ thực thi các câu lệnh được liệt kê ra và kết quả thu được sẽ được dùng cho bước tiếp theo trong Docker file. Có 2 dạng để viết RUN, các bạn có thể tùy chọn.
	Shell from: RUN <command>
	Exec form: RUN ["executable", "param1", "param2"]
ví dụ:  FROM ubuntu:18.04
	RUN apt-get update
	RUN apt-get install -y curl nginx
Sử dụng RUN apt-get update && apt-get install -y đảm bảo Dockerfile của bạn cài đặt các phiên bản gói mới nhất mà không cần thêm mã hóa hoặc can thiệp thủ công
/COPY: Copy một file từ host machine tới docker image. Có thể sử dụng URL cho tệp tin cần copy, khi đó docker sẽ tiến hành tải tệp tin đó đến thư mục đích.
/ENV: Định nghĩa các biến môi trường
/CMD: trong 1 dockerfile chỉ có thể có 1 phần CMD. Nếu viết nhiều hơn thì nó sẽ chỉ chạy theo phần CMD cuối cùng. Mục đích của CMD là cung cấp các thiết lập mặc định cho execute Docker container. Có 3 dạng để viết CMD:
	Shell form: CMD command param1 param2
	Exec form (cách này được sử dụng nhiều nhất): 
	CMD ["executable","param1","param2"]
	Coi như tham số mặc định cho ENTRYPOINT: CMD ["param1","param2"]
	Docker image
Docker images là cơ sở của containers. Một Image là một tập hợp các lệnh và các tham số thực thi tương ứng sử dụng trong thời gian container đang chạy. Một Image thường chứa một loạt các tập tin hệ thống xếp lớp chồng lên nhau. Một Image sẽ không bao giờ bị thay đổi. Chúng ta cũng có thể download các Image có sẵn từ Docker hub để sử dụng.
	Docker container
Chạy Docker Image xong sẽ thu được Docker Container.
Một Docker Container có thể có các trạng thái run, started, stopped, moved, deleted.
Một số câu lệnh thường sử dụng khi dùng Container:
+ docker container ls 	#liệt kê danh sách các container 
+ docker container restart #khởi động lại container
+ docker container start #bắt đầu chạy container
+ docker container stop  #đóng container đang chạy
+ docker container kill  #dừng container đang chạy ngay lập tức
+ docker container top  #hiển thịn những quy trình đang chạy của container
+ docker container port #liệt kê các cổng mà container đang sử dụng
*Tạo dockerfie
b1:
tạo một directory mới cho dockerfile  và tiến hành định nghĩa những thứ muốn làm với dockerfile:
$mkdir toan
$cd toan
$touch Dockerfile
mở Dockerfile
#Download image ubuntu 16.04
FROM ubuntu 16.04
#tiến hành update ubuntu software bên trong container bằng lệnh RUN
RUN apt-get update
####viết Dockerfile và docker-compose cho code đã viết ở đây
####
version: '3.3'

services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: somewordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    image: wordpress:latest
    ports:
      - 8000:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    depends_on:
      - db
      - pma
  
  pma:
    image: phpmyadmin/phpmyadmin
    environment:
      PMA_HOST: db
      PMA_PORT: 3306
      MYSQL_ROOT_PASSWORD: somewordpress
    restart: always
    ports:
      - 8020:80
    depends_on:
      - db

volumes:
  db_data: {}

####tham khảo
https://www.digitalocean.com/community/tutorials/how-to-build-and-deploy-a-flask-application-using-docker-on-ubuntu-18-04
