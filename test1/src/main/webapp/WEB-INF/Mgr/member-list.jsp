<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
         <table>
            <h2>회원 목록</h2>
            <tr>
                <th>유저 아이디</th>
                <th>이름</th>
                <th>생년월일</th>
                <th>닉네임</th>
                <th>성별</th>
                <th>로그인 오류 횟수</th>
                <th>계정 정지 해제</th>          
            </tr>
            <tr v-for="item in list">
                <td>
                    <a href="javascript:;" @click="fnView(item.userId)">{{item.userId}}</a>
                </td>              
                <td>{{item.name}}</td>  
                <td>{{item.cBirth}}</td>  
                <td>{{item.nickName}}</td>
                <td>{{item.gender}}</td>
                <td>{{item.cnt}}</td>
                <td><button v-if="item.cnt >= 5" @click="fnReset(item.userId)">해제</button></td> 
            </tr>
         </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                list : {}
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/mgr/member/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                    }
                });
            },
            fnReset : function(userId){
                let self = this;
                let param = {
                    id : userId
                };
                $.ajax({
                    url: "/mgr/member/list/reset.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success") {
                            alert("해제 완료");
                            self.fnList();
                        } else {
                            alert("오류 발생;")
                        }          
                    }
                });

            },
            fnView (userId){
                pageChange("/mgr/member/view.do",{userId : userId});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>