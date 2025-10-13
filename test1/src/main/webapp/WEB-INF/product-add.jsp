<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
        <h3>음식 추가</h3>
        음식 종류 : 
        <select id="kind">      
            <option value="10">한식</option>
            <option value="20">중식</option>
            <option value="30">양식</option>
        </select>
        <div>
            <label>이름: <input type="text" v-model="name"></label>
        </div>
        <div>
            <label>가격: <input type="text" v-model="price"></label>
        </div>
        <div>
            <label>설명: <input type="text" v-model="info"></label>
        </div>
        <div>
            <label>이미지: <input type="file" v-modul="image"></label>
        </div>
        <button @click="fnAdd">추가</button>
        <button>취소</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                name : "",
                price : "",
                info : "",
                image : "",
                kind : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = {
                    name : self.name,
                    price : self.price,
                    info : self.info,
                    kind : self.kind

                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {

                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>