VOLUME
VOLUME nên được sử dụng để hiển thị bất kỳ vùng lưu trữ cơ sở dữ liệu, lưu trữ cấu hình hoặc tệp / thư mục được tạo bởi docker container của bạn. Bạn được khuyến khích sử dụng VOLUME cho bất kỳ phần có thể thay đổi và / hoặc người dùng có thể sử dụng được trong image của bạn.

tạo 1 directory: mkdir testdocker
di chuyển vào đó:cd testdocker 
tạo 1 folder để chứ app: mkdir web
di chuyển vào nó: cd web
tạo 1 file có tên là app.py

from flask import Flask, render_template
 
app = Flask(__name__)
 
 
@app.route('/')
def hello_whale():
    return render_template("whale_hello.html")
 
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
tạo file requirements.txt
Flask==0.12

dockerfile
FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
COPY ~/learn-python /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]

built image
docker build -t flask-sample:latest .

run container
docker run -d -p 5000:5000 flask-sample

docker-compose: tại thư mục testdocker tạo docker-compose.yml với nội dung:
web:
  build: ./web
  ports:
   - "8000:5000"
  volumes:
   - .:/code
chạy lệnh: docker -compose up
///////////////////////////////////
# Dockerfile
là một tài liệu dạng văn bản chứa tất cả các câu lệnh mà người dùng muốn gọi đến ở trong giao diện command-line. Từ Dockerfile này, chỉ với 1 câu lệnh docker build là Docker sẽ tự động xây dựng nên một Docker image.
Tạo Dockerfile cho ứng dụng.
clone repo chứa app trên github:
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-22%2022-38-13.png?raw=true)
tạo file Dockerfile và thêm nội dung vào bên trong:
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-22%2022-38-46.png?raw=true)

```sh
FROM python:3.7-alpine
ENV FLASK_RUN_HOST 0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
CMD ["flask","run"]
```
 + FROM:  khai báo image được khởi tạo được xây dừng từ image gốc là python 3.7
 + ENv: định nghĩa biến môi trường cho flask chạy với địa chỉ là 0.0.0.0
 + RUN: Không sử dụng bộ đệm khi build image, cài trình biên dịch gcc, musl-dev, linux-headers để cung cấp các gỏi tiêu đề linux-kernel
 + WORKDIR /app: xác định thư mục làm việc
 + COPY: sao chép nội dung của file requirements.txt vào thư mục requirements.txt trong container
 + RUN: cài đặt các yêu cầu cần thiết đã được ghi trong thư mục requirement.txt
 + CMD: chạy lệnh flask run
Sau khi thiết lập xong Dockerfile, tiến hành biuld image.
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-22%2022-43-01.png?raw=true)
ở đây, do k đặt tên image nên phải xác định bằng image I(ở đây em dùng image 47b)
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-23%2000-24-58.png?raw=true)
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-23%2000-25-34.png?raw=true)
run container:
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-23%2000-34-05.png?raw=true)
kết quả:
![alt](https://github.com/toantd1202/buoc1/blob/master/Screenshot%20from%202020-03-22%2022-53-55.png?raw=true)


