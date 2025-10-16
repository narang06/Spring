<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <h1>상세 보기</h1>
        <table id="board">
                <tr>
                    <th>음식명</th>
                    <td>{{info.foodName}}</td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td>{{info.price}}</td>
                </tr>
                <tr>
                    <th>분류</th>
                    <td>{{info.foodKind}}</td>
                </tr>  
                <tr>
                    <th>정보</th>
                    <td>
                        <img v-for="item in fileList" :src="item.filePath">
                        <br>
                        {{info.foodInfo}}
                    </td>
                </tr> 
                <tr>
                    <th>개수</th>
                    <td><input v-model="num"></td>
                </tr> 
            </table>
            <div>
                <button @click="fnPayment">주문하기</button>
            </div>
    </div>
</body>
</html>

<script>
    const userCode = "imp32541437"; 
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                foodNo : "${foodNo}",
                info : {},
                fileList : [],
                num : 1,
                sessionId : "${sessionId}",
                merchant_uid : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    foodNo : self.foodNo
                };
                $.ajax({
                    url: "/product-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        self.fileList = data.fileList;
                    }
                });
            },
            fnPayment(){
                let self = this;
                const amountToPay = 1 //self.info.price * self.num;

                if (isNaN(amountToPay) || amountToPay <= 0) {
                    alert("결제 금액이 올바르지 않습니다.");
                    return;
                }
                IMP.request_pay({
                    pg: "html5_inicis",
                    pay_method: "card",
                    merchant_uid: "merchant_" + new Date().getTime(),
                    name: self.info.foodName,
                    amount: amountToPay, 
                    buyer_tel: "010-0000-0000",
                }, function (rsp) { // callback
                    if (rsp.success) {
                        // 결제 성공 시          
                        console.log(rsp);
                        self.fnpayHistory(rsp.imp_uid,rsp.paid_amount);
                    } else {
                        // 결제 실패 시
                        alert("실패");
                    }
                });
            },
            fnpayHistory(uid,amount){
                let self = this;
                let param = {
                    foodNo : self.foodNo,
                    uid : uid,
                    amount : amount,
                    userId : self.sessionId
                };
                $.ajax({
                    url: "/product/payment.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("결제되었습니다.");
                        } else {
                            alert("오류가 발생했습니다.")
                        }
                    }
                });
            }  
        },
        // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>