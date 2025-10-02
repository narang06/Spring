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
        #board table,  tr,  td,  th{
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
            <p>-- 본문 --</p>
            <table id="board">
                <tr>
                    <th>제목</th>
                    <td>{{info.title}}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>{{info.userId}}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>{{info.cnt}}</td>
                </tr>  
                <tr>
                    <th>내용</th>
                    <td>
                        <img v-for="item in fileList" :src="item.filePath">
                        <br>
                        {{info.contents}}
                    </td>
                </tr>  
            </table>
            <button @click="fnBack()">뒤로가기</button>
            <button @click="fnUpdate(boardNo)">수정</button>  
        </div>
        <p>--댓글--</p>
        <div>
            <table id="comment">
                <template v-for="comment in commentList">
                    <tr>
                        <th>댓글 작성자</th>
                        <td>{{comment.nickName}}</td>
                        <th v-if="comment.userId == sessionId || status == 'A'">
                            <button @click="fnCommentDelete(commentNo)">삭제</button>
                        </th>
                    </tr>  
                    <tr>
                        <th>댓글 내용</th>
                        <td>{{comment.contents}}</td>
                        <th v-if="comment.userId == sessionId">
                            <button @click="fnCommentUpdate">수정</button>
                        </th>
                    </tr>        
                </template> 
            </table>
        </div>
        <p>-- 입력창--</p>
        <table id="commentInput">
            <th>댓글 입력</th>
            <td>
                <textarea cols="40" rows="4" v-model="comment"></textarea>
            </td>
            <td>
                <button @click="fnCommentAdd">저장</button>
            </td>
        </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo : "${boardNo}",
                info : {},
                commentList : [],
                comment : "",
                sessionId : "${sessionId}",
                status : "${sessionStatus}",
                fileList : []
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.info = data.info;
                        self.commentList = data.commentList;
                        self.fileList = data.fileList;
                    }
                });
            },
            fnBack(){
                history.back();
            },
            fnUpdate(boardNo){
                pageChange("board-add.do", {boardNo : boardNo});
            },
            fnCommentAdd (){
                let self = this;
                let param = {
                    boardNo : self.boardNo,
                    id : self.sessionId,
                    comment : self.comment
                };
                $.ajax({
                    url: "/comment/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("댓글이 추가되었습니다.");
                        self.comment = "";
                        self.fnInfo();
                    }
                });
            },
            fnCommentDelete(commentNo){
                let self = this;
                let param = {
                    commentNo : commentNo
                };
                $.ajax({
                    url: "/comment/delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);
                        self.fnInfo();
                    }
                });
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