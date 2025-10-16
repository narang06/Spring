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
        .boardTitle{
            color: red;
        }
        #index {
            margin-right: 5px;
            text-decoration: none;
        }
        .active{
            color: black;
            font-weight: bold;
        }
        a{
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div id="app">
        <div>
            <select v-model="search" @change="fnList">
                <option value="1">:: 전체 ::</option>
                <option value="2">:: 제목 ::</option>
                <option value="3">:: 작성자 ::</option>
            </select>
            <input placeholder="검색" v-model="keyword">
		    <button @click="fnList()">검색</button>
        </div>
        <div>
            <select v-model="pageSize" @change="fnList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="20">20개씩</option>
            </select>

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
                <option value="4">:: 시간순</option>
                <option value="5">:: 댓글수순</option>
            </select>
        </div>	
        <div>
            <table>
                <tr>
                    <th><input type="checkbox" @click="fnAllCheck" v-if="status == 'A'"></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>
                        <input type="checkbox" :value="item.boardNo" v-model="selectItem">
                    </td>
                    <td>{{item.boardNo}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
                        <span v-if="item.commentCount !=0" class="boardTitle"> [{{item.commentCount}}]</span>
                    </td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cdate}}</td>
                    <td>
                        <button @click="fnDelete(item.boardNo)" 
                        v-if="item.userId == sessionId || status == 'A'">
                            삭제
                        </button>
                    </td>
                </tr>  
            </table>
            <div>
                <a href="board-add.do"><button>글 작성</button></a>
                <button @click="fnAllRemove" v-if="status == 'A'">선택 삭제</button> 
            </div>
            <a href="javascript:;" @click="fnPageDown" v-if="page > 1">◀</a>
            <a href="javascript:;" v-for="num in index" id="index" @click="fnpageChange(num)">
                <span :class="{active : page == num}">
                    {{num}}
                </span>
            </a>
            <a href="javascript:;" @click="fnPageUp" v-if="page < index">▶</a>
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
                sort : 1,
                search : 1,
                keyword : "",
                pageSize : 5,
                page : 1, // 현재 페이지
                index : 0, // 최대 페이지 값
                sessionId : "${sessionId}",
                status : "${sessionStatus}",
                selectItem : [],
                selectFlg : false
                
                
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    sort : self.sort,
                    keyword : self.keyword,
                    search : self.search,
                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize
                };
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);

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
            },
            fnpageChange : function(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
            fnPageDown (){
                let self = this;   
                self.page--;
                self.fnList();
                
            },
            fnPageUp(){
                let self = this;
                self.page++;
                self.fnList();
            },
            fnAllCheck(){
                let self = this;
                self.selectFlg = !self.selectFlg;

                if(self.selectFlg){
                    self.selectItem= [];
                    for(let i = 0; i<self.list.length; i++){
                    self.selectItem.push(self.list[i].boardNo);
                    }
                } else {
                    self.selectItem = [];
                }            
            },
            fnAllRemove(){
                let self = this;

                var fList = JSON.stringify(self.selectItem);
                var param = {selectItem : fList};
               
                $.ajax({
                    url: "/board/deletelist.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("선택하신 항목이 삭제되었습니다.");
                        self.fnList();
                    }
                });
            },
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>