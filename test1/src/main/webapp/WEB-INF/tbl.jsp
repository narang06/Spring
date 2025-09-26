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
        <div>
            <select v-model="kind" @change="fnList">
                <option value="">전체</option>
                <option value="1">공지사항</option>
                <option value="2">자유게시판</option>
                <option value="3">문의게시판</option>
            </select>
            <select v-model="sort" @change="fnList">
                <option value="1">:: 번호순</option>
                <option value="2">:: 제목순</option>
                <option value="3">:: 조회순</option>
            </select>
        </div>
		<input placeholder="검색" v-model="boardNo">
		<button @click="fnSearch()">검색</button>
        <div>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardNo}}</td>
                    <td><a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a></td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cdate}}</td>
                    <td><button @click="fnDelete(item.boardNo)">삭제</button></td>
                </tr>
            </table>
            <a href="board-add.do"><button>추가</button></a>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                list : {},
                kind : "",
                sort : 1
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    sort : self.sort
                };
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.list = data.list;

                    }
                });
            },

            fnDelete: function (boardNo) {
                let self = this;
                let param = {
                    boardNo : boardNo
                };
                $.ajax({
                    url: "board-list-delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제 완료");
                        self.fnList();
                    }
                });
            },
            fnView: function (boardNo) {
               pageChange("board-view.do", {boardNo : boardNo});
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