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
        <table>
            <tr>
                <th>제목</th>
                <td><input type="text" v-model="title"></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>{{sessionId}}</td>
            </tr>
            <tr>
                <th>파일첨부</th>
                <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
            </tr> 
            <tr>
                <th>내용</th>
                <td><textarea v-model="content" cols="40" rows="20"></textarea></td>
            </tr>     
        </table>
        <button @click="fnAdd()">작성</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                title : "",
                userId : "",
                content : "",
                info : {},
                sessionId : "${sessionId}"
                
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = {
                    title : self.title,
                    userId : self.sessionId,
                    content : self.content
                };
                $.ajax({
                    url: "board-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("추가되었습니다.");
                        console.log(data.boardNo);
                        var form = new FormData();
                        form.append( "file1",  $("#file1")[0].files[0] );
                        form.append( "boardNo",  data.boardNo);  
                        self.upload(form);
                        // location.href="board-list.do"
                    }
                });
            },
            fnList: function () {
                let self = this;
                let param = {
                };
                $.ajax({
                    url: "",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        
                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/fileUpload.dox",
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
            self.fnList();
            if(self.sessionId == ""){
                alert("로그인 후 이용해주세요.");
                location.href ="/member/login.do";
            }
        }
    });

    app.mount('#app');
</script>