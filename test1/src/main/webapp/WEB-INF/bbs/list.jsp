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
         <div>
            <div>
                <select v-model="pageSize" @change="fnList">
                    <option value="3">3개씩</option>
                    <option value="5">5개씩</option>
                    <option value="10">10개씩</option>
                </select>
                <select v-model="search" @change="fnList">
                    <option value="1">:: 전체 ::</option>
                    <option value="2">:: 제목 ::</option>
                    <option value="3">:: 작성자 ::</option>
                </select>
                <input placeholder="검색" v-model="keyword">
                <button @click="fnList">검색</button>
            </div>  
            <table>
                <tr>
                    <th></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="radio" :value="item.bbsNum" v-model="selectItem"></td>
                    <td>{{item.bbsNum}}</td>
                    <td><a href="javascript:;" @click="fnView(item.bbsNum)">{{item.title}}</a></td>
                    <td>{{item.userId}}</td>
                    <td v-if="item.hit >= 25" style="color: red;">{{item.hit}}</td>
                    <td v-else style="color: black;">{{item.hit}}</td>
                    <td>{{item.udatetime}}</td>         
                </tr>
            </table>      
            <button @click="fnRemove(selectItem)">선택 삭제</button>
            <a href="/bbs/add.do"><button>글쓰기</button></a>
            <a href="javascript:;" v-for="num in index" id="index" @click="fnpageChange(num)">
                <span :class="{active : page == num}">
                    {{num}}
                </span>
            </a>
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
                search: 1,
                keyword : "",
                pageSize : 10,
                page : 1,
                index : 0,
                sessionId : "${sessionId}",
                selectItem : null
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    keyword : self.keyword,
                    search : self.search,
                    page: (self.page-1) * self.pageSize,
                    pageSize : self.pageSize
                };
                $.ajax({
                    url: "/bbs/list.dox",
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
            fnpageChange : function(num){
                let self = this;
                self.page = num;
                self.fnList();
            },
            fnRemove(bbsNum){
                let self = this;
                let param = {
                    bbsNum : bbsNum
                };
                $.ajax({
                    url: "/bbs/delete.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제 완료");
                        self.fnList();
                    }
                });
            },
            fnView: function (bbsNum) {
               pageChange("/bbs/view.do", {bbsNum : bbsNum});
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