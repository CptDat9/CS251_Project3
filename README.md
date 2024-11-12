# CS251 Project 3 - Hardhat Project

<p align="center">
<a href="https://git.io/typing-svg"><img src="https://readme-typing-svg.demolab.com?font=Fira+Code&pause=1000&center=true&vCenter=true&random=false&width=450&lines=CS251+Project3" alt="Typing SVG" /></a>
</p>
<div align="center">
<img alt="Static Badge" src="https://img.shields.io/badge/Astar-group-blue?labelColor=EE4E4E&color=151515">
<img alt="Static Badge" src="https://img.shields.io/badge/Security-Research-blue?labelColor=e7ec89&color=3ddd2b&label=Security">
<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/CptDat9/CS251_Project3?labelColor=7AA2E3&color=97E7E1">
</div>
This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

## Hướng dẫn tạo Hardhat Project - Splitwise contract

## Mục lục
- [Giới thiệu](#giới-thiệu)
- [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
- [Cài đặt project](#cài-đặt-project)
- [Thuật toán IOU](#thuật-toán-IOU)
- [Các lệnh cơ bản](#các-lệnh-cơ-bản)
- [Ứng dụng Web](#ứng-dụng-web)
- [Thông tin bổ sung](#thông-tin-bổ-sung)
- [Minh họa](#minh-họa)

## Giới thiệu
Dự án này xây dựng một hệ thống **IOU** (I Owe You) đơn giản để theo dõi các khoản nợ giữa các địa chỉ trên blockchain. Hệ thống bao gồm các hợp đồng thông minh cho **IOU**, các **script** để triển khai hợp đồng, và giao diện web cơ bản để tương tác với các chức năng của hệ thống. 
Mục tiêu là triển khai hợp đồng trên **BSC Testnet** và tích hợp chúng vào một ứng dụng web.

 ### Dự án này gồm:

 + Hợp đồng thông minh cho hệ thống **IOU**.
 + Các bài kiểm thử để đảm bảo tính toàn vẹn của hệ thống.
 + Cấu hình **Hardhat** để triển khai và kiểm thử hợp đồng.
 + Ứng dụng **web3/Dapps**.
## Yêu cầu hệ thống
- **Node.js** và **npm** phiên bản mới nhất.
- **Hardhat** để triển khai và quản lý project.
- **Git** để quản lý mã nguồn.
## Cài đặt project
### Bước 1: Tạo thư mục project mới và khởi tạo **Hardhat**
Mở `terminal` và tạo một thư mục mới cho project của bạn:

```bash
mkdir CS251HardhatProject
cd CS251HardhatProject
npm init -y
npm install --save-dev hardhat
npx hardhat
```
Chọn **Create a basic sample project** khi được hỏi để tạo các tệp mẫu.
### Bước 2: Cấu hình **Hardhat**
Thêm cấu hình vào `hardhat.config.js` nếu cần, ví dụ:
```javascript
require("@nomiclabs/hardhat-waffle");
module.exports = {
  solidity: "0.8.17",
};
```
### Bước 3: Cài đặt các gói hỗ trợ
Cài đặt các thư viện cần thiết:

```bash
npm install --save-dev @nomicfoundation/hardhat-toolbox
npm install dotenv
```
### Bước 4: Cấu hình tệp **.env**
Sử dụng tệp `.env` để lưu thông tin nhạy cảm như `API_URL` và `PRIVATE_KEY`:

```plaintext
API_URL=https://<Infura_or_Alchemy_URL>
PRIVATE_KEY=<Your_Private_Key>
```
Cập nhật `hardhat.config.js` để lấy giá trị từ `.env`:

```javascript
require("dotenv").config();
module.exports = {
  solidity: "0.8.17",
  networks: {
    rinkeby: {
      url: process.env.API_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
```
## Thuật toán IOU
Hệ thống **IOU** (I Owe You) này sử dụng thuật toán cập nhật các khoản nợ giữa các địa chỉ. 
### Các điểm chính của hệ thống:

- Theo dõi khoản nợ: Mỗi lần **add_IOU** được gọi, hệ thống lưu thông tin ai nợ ai và số tiền.
- Tìm đường đi: Sử dụng thuật toán **BFS** để xác định chuỗi các khoản nợ qua lại giữa các địa chỉ và tối thiểu hóa nợ.
- Tối ưu hóa nợ: Nếu có chuỗi nợ, hệ thống giảm nợ trên chuỗi này bằng cách cập nhật giá trị nhỏ nhất giữa các khoản nợ.
- Tự động cập nhật: Nếu có sự thay đổi, các khoản nợ được cập nhật tương ứng để tối ưu hóa việc trả nợ.
- Ví dụ, nếu A nợ B 10 và B nợ C 10 C nợ A 14, việc gọi **add_IOU** sẽ giúp cập nhật trạng thái và tối ưu hóa bằng cách giảm số nợ của A, B và đưa về thành C nợ A 14-10 = 4 (trừ đi cạnh có trọng số min trong đồ thị).

## Các lệnh cơ bản
- Hiển thị trợ giúp
```bash
npx hardhat help
```
- Chạy kiểm thử (cần tạo file test để test).
```bash
npx hardhat test
```
- Khởi động mạng Hardhat node
```bash
npx hardhat node
```
- Triển khai hợp đồng
```bash
npx hardhat run scripts/deploy.js
```
## Ứng dụng Web
Ứng dụng web này cho phép người dùng tạo và theo dõi các khoản nợ bằng giao diện đơn giản. Các tệp chính trong ứng dụng web:

`1. index.html`
- Tạo một giao diện cơ bản để nhập thông tin và kết nối với hợp đồng thông minh.

`2. style.css`
- Định dạng giao diện với các kiểu dáng CSS cơ bản.

`3. script.js`
- Kết nối với blockchain và hợp đồng thông qua web3.js hoặc ethers.js.
## Thông tin bổ sung
- **Git**: Project được khuyến khích quản lý qua Git để theo dõi các thay đổi.
- **MetaMask**: Dùng để kết nối với mạng blockchain thử nghiệm.
- **Hardhat Network**: Cung cấp một mạng blockchain cục bộ và cho phép thử nghiệm các tính năng mà không cần phí gas thực tế. (tôi sử dụng BNB Smart Chain Testnet).
## Minh họa
![image](https://github.com/user-attachments/assets/ce0a8a29-401a-4a65-bf4f-6cfe2e4662aa)
![image](https://github.com/user-attachments/assets/47dee140-22ed-47a3-9018-7436ebbc0a3c)
![image](https://github.com/user-attachments/assets/c188be32-9340-446a-8152-378c32ef45ed)
![image](https://github.com/user-attachments/assets/8bd4d389-a948-48b5-856c-201d9fcce798)
![image](https://github.com/user-attachments/assets/b4bf6299-e150-4281-91d6-5387ae887aa1)
![image](https://github.com/user-attachments/assets/9a5d182e-425d-49fc-bcda-af199a91169c)

