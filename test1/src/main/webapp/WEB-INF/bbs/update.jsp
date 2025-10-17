<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
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
        #editor {
            width: 100%;
            height: 300px;
        }
    </style>
</head>
<body>
    <div id="app">
        <table>
            <tr>
                <th>제목</th>
                <td><input v-model="title" placeholder="제목"></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>{{sessionId}}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea v-model="contents" cols="25" rows="5"></textarea></td>
            </tr>     
        </table>
        <button @click="fnEdit">완료</button>
        <button @click="fnBack">뒤로가기</button>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                sessionId : "${sessionId}",
                title : "",
                contents : "",
                bbsNum : "${bbsNum}"   
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    bbsNum : self.bbsNum
                };
                $.ajax({
                    url: "/bbs/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result == "success"){
                            self.title = data.info.title;
                            self.contents = data.info.contents;
                        } else {
                            alert("오류가 발생했습니다!");
                        }
                    }
                });
            },
            fnEdit : function () {
                let self = this;
                let param = {
                    bbsNum : self.bbsNum,
                    title : self.title,
                    contents : self.contents
                };
                $.ajax({
                    url: "/bbs/update.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == "success"){
                            alert("수정되었습니다!");
                            location.href = "/bbs/list.do";
                        } else {
                            alert("오류가 발생했습니다!");
                        }
                    }
                });
            },
            fnBack(){
                history.back();
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
            
        }
    });

    app.mount('#app');
</script>