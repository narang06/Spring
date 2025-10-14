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
        <select v-model="menuPart">      
            <option v-for="item in menuList" :value="item.menuNo">{{item.menuName}}</option>
        </select>
        <div>
            <label>제품 번호: <input v-model="menuNo" class="txt"></label>
        </div>
        <div>
            <label>이름: <input type="text" v-model="foodName"></label>
        </div>
        <div>
            <label>가격: <input type="text" v-model="price"></label>
        </div>
        <div>
            <label>설명: <textarea v-model="foodInfo" cols="25" rows="5"></textarea></label>
        </div>
        <div>
            <label>이미지: <input type="file" id="file1" name="file1" accept=".jpg, .png"></label>
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
                foodName : "",
                price : "",
                foodInfo : "",
                menuList : [],
                menuPart : "10",
                menuNo : "",
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = {
                    foodName : self.foodName,
                    price : self.price,
                    foodInfo : self.foodInfo,
                    menuNo : self.menuNo,
                    menuPart :self.menuPart
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result == "success") {
                            var form = new FormData();
                            form.append( "file1",  $("#file1")[0].files[0] );
                            form.append( "foodNo",  data.foodNo);  
                            self.upload(form);
                            // alert("메뉴 추가 완료");
                            // location.href="p"
                        } else {
                            alert("오류 발생");
                        }
                    }
                });
            },
            fnMenuList() {
                var self = this;
                var param = {
                    depth : 1
                };
                $.ajax({
                    url: "/product/menu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.menuList = data.menuList;

                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/product/fileUpload.dox",
                    type : "POST",
                    processData : false,
                    contentType : false,
                    data : form,
                    success:function(data) { 
                        console.log(data)
                    }	           
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnMenuList();
        }
    });

    app.mount('#app');
</script>