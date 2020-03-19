# I. Tổng quan về Docker
Docker là một nền tảng mở để phát triển, vận chuyển và chạy các ứng dụng. Docker cho phép người dùng tách các ứng dụng khỏi cơ sở hạ tầng để có thể triển khai phần mềm một cách nhanh chóng nhờ vào các container.
Docker được tạo ra để làm việc trên nền tảng Linux , nhưng đã mở rộng để cung cấp hỗ trợ lớn hơn cho các hệ điều hành không phải Linux, bao gồm Microsoft Windows và Apple OS X.
##### 1. công nghệ containerlization
Trên một máy chủ vận lý ta tạo ra nhiều máy con(Guess OS), các máy con này đều dùng chung phần nhân của máy mẹ(Host OS) và chia sẻ với nhau tài nguyên máy mẹ. khi nào cần, cần bao nhiêu tài nguyên thì sẽ được đáp ứng đảm vảo việc sử dụng tối ưu tài nguyên Host OS.
![alt](https://viblo.asia/uploads/5fdfbb3b-de87-4b24-a65c-3cf8753bfa15.png)
##### 2. Container
Là một giải pháp để chuyển giao phần mềm một cách đáng tin cậy giữa các môi trường máy tính khác nhau bằng cách:
* Tạo ra môi trường chứa mọi thứ mà phần mềm cần để có thể chạy được.
* Không bị các yếu tố liên quan đến hệ thống làm ảnh hưởng.
* Không làm ảnh hưởng tới các phần còn lại của hệ thống.
Các process trong một container bị cô lập với các process của các container khác nhưng chúng cùng chia sẻ kernel của Host OS.
Ưu điểm:
* Linh động: triển khai ở bất kì đâu do các ứng dụng phụ thuộc vào tầng OS và cơ sở hạ tầng được loại bỏ.
* Nhanh: Do chia sẻ host OS nên container có thể được tạo gần như một cách tức thì.
* Nhẹ: Container cũng sử dụng chung các images nên cũng không tốn nhiều disks.
* Đồng nhất: Khi nhiều người dùng cùng phát triển trong cùng một dự án sẽ không bị ảnh hưởng bởi sự sai khác về mặt môi trường.
* Đóng gói: Có thể ẩn môi trường và app vào trong một gói gọi là container. Có thể test được các container, việc bỏ hay tạo lại container dễ dàng.
	Nhược điểm:
* Nếu kernel của Host OS có bất cứ lỗ hổng nào thì nó sẽ ảnh hưởng đến tất cả các container do dùng chung OS.
# II. Cài đặt và cấu hình
##### 1. Cài đặt Docker trên Linux
```sh
    $sudo apt-get update
    $sudo apt install docker.io
    $sudo systemctl start docker
    $sudo systemctl enable docker
```
Sau khi cài đặt docker, ta chỉ có thể chạy được Docker command với user thông thường với quyền sudo hoặc user root, nghĩa là mỗi lần dùng docker command thì phải gõ sudo đằng trước nếu không thì sẽ gặp lỗi “Permission Denied”. Để giải quyết vấn đề này, đó là tạo 1 group là docker và thêm user vào group này thông qua việc thực hiện các lệnh:

```sh
    $ sudo addgroup --system docker
	$ sudo adduser <username> docker
	$newgrp docker
```
##### 2. Cấu hình proxy
###### a. kiến trúc của Docker
![alt](https://user-content.gitlab-static.net/a4b100b0aff6883a6bc88b92e9f7184cc85d52b6/68747470733a2f2f692e696d6775722e636f6d2f36477036627a762e706e67)
Docker sử dụng kiến trúc client-server. Docker client sẽ liên lạc với các Docker daemon, các Docker daemon sẽ thực hiện tác vụ build, run và distribuing các Docker container. Cả Docker client và Docker daemon có thể chạy trên cùng một máy, hoặc có thể kêt nối theo kiểu docker client điều khiển các docker daemon như hình. Docker client và Docker daemon giao tiếp với nhau qua socket hoặc RESTful API.
Docker daemon chạy trên máy host, người dùng sẽ không tương tác trực tiếp với các daemon mà thông qua các Docker client.
Docker image: là thành phần để đóng gói ứng dụng và các thành phần mà ứng dụng phụ thuộc để chạy. Và image được lưu trữ ở trên local hoặc trên một Registry (là nơi lưu trữ và cung cấp kho chứa các image DockerHub). Mỗi program được khởi tạo từ Docker image được gọi là Docker container
###### b. cấu hình proxy cho docker deamon
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2016-58-33.png)
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2016-59-58.png)
+Reload và restart lại:
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2016-59-11.png)
###### c. Cấu hình proxy cho docker client
Docker client: đây là cách mà bạn tương tác với docker thông qua command trong terminal. Khi đó docker client sẽ sử dụng API và gửi lệnh tới Docker Daemon.
###### Tạo và sửa file ~/.docker/config.json
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2018-03-52.png)
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2017-07-07.png)
##### 3. Hello world với Docker
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2016-46-18.png)
# III. Các câu lệnh cơ bản
##### 1. Docker tag: 
Tạo thẻ TARGET_IMAGE cho SOURCE_IMAGE
cú pháp:
```sh	
	docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[TAG]
```

ví dụ:
```sh
    $ docker tag httpd:test fedora/httpd:version1.0.test
```
Để gắn thẻ một local image có tên là “httpd” và gắn thẻ “test” vào repository của “fedora” với “version1.0.test”.
##### 2. Docker run: 
Lệnh này dùng để chạy một container dựa trên một image mà ta có sẵn. Ta có thể thêm vào sau lệnh này một vài câu lệnh khác như -it bash để chạy bash từ container này.
     cú pháp: 
```sh     
	$ docker run [OPTIONS] IMAGE [COMMAND] [ARG…]
```
ví dụ: 
```sh
	$ docker run  --name ubuntu_bash –rm -i -t ubuntu bash
```
lệnh trên sẽ tạo một container mới với tên ‘ubuntu_bash’ và khởi động một phiên bản shell Bash trong container.
Một số [options] thường dùng:
	--name: Gán tên cho container
	--rm: Tự động loại bỏ container khi nó thoát
	--workdir, -w: Thư mục làm việc bên trong container
	--detach, -d: Chạy container trong b và in ID container
    --volumes, -v: Gắn kết một  volume

##### 3. Docker build: 
Lệnh này dùng để build một image từ Dockerfile và context. Context ở đây là một tập file được xác đinh bởi đường dẫn hoặc url cụ thể. Ta có thể sử dụng thêm tham số -t để gắn nhãn cho image.
	cú pháp:
```sh
$ docker build [OPTIONS] PATH | URL | -
```
ví dụ: 
```sh
     $ docker build https://github.com/docker/rootfs.git#container:docker
```
hoặc:
```sh
     $ docker build -t your_name_container
```

Một số [options] thường dùng:
--tag, -t: Đặt tên và tùy chọn một thẻ theo định dạng ‘name: tag’
--rm: Loại bỏ các container trung gian sau khi xây dựng thành công
--force-rm: Luôn loại bỏ các container trung gian.
##### 4. Docker push: Đẩy một image lên một repo (DockerHub)
Tạo 1 tài khoản trên dockerhub, tạo 1 repo.
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-19%2022-57-11.png)
```sh
 $ docker push b16dcvt311/name_image
```
##### 5. Docker pull: 
Tải một image về máy
cú pháp:
```sh
	$ docker pull <image_name:tag>
```
![alt](https://raw.githubusercontent.com/toantd1202/photo/master/Screenshot%20from%202020-03-20%2000-21-21.png)

