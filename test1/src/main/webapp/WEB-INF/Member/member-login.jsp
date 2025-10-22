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
        <div>
            <div>
                <label>아이디: <input v-model="id"></label>
            </div>
            <div>
                <label>비밀번호: <input type="password" v-model="pwd"></label>
            </div>
            <div>
                <button @click="fnLogin">로그인</button>
                <a href="/member/join.do">
                    <button>회원가입</button>
                </a>
                <a href="/member/pwd.do">
                    <button>비밀번호 찿기</button>
                </a>
            </div>
             <a :href="location">
                <img src="/img/kakao_login.png" alt="카카오 로그인">
            </a>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                id : "",
                pwd : "",
                location : "${location}"
            };
        },
        methods: {
            fnLogin: function () {
                let self = this;
                let param = {
                    id : self.id,
                    pwd : self.pwd
                };
                $.ajax({
                    url: "/member/login.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert(data.msg);
                        if(data.result == "admin"){
                            location.href="/mgr/member/list.do"; // 관리자일 경우 회원관리 페이지로 이동
                        } else if(data.result == "success") {
                           location.href="/main.do"; 
                        }
                        
                    }
                });
            }
        }, // methods
        mounted() {
            let self = this;

        }
    });

    app.mount('#app');
</script>