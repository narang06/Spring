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
        .active{
            color: black;
            font-weight: bold;
        }
        a{
            text-decoration: none;
            padding-left: 5px;
        }
    </style>
</head>
<body>
    <div id="app">
        도/특별시 :
        <select v-model="si" @change="fnSiChange">
            <option value="">:: 전체 ::</option>
            <option :value="item.si" v-for="item in siList">{{item.si}}</option>
        </select>
        구 :
        <select v-model="gu" @fnGuChange>
            <option value="">:: 선택 ::</option>
            <option :value="item.gu" v-for="item in guList">{{item.gu}}</option>
        </select>
        동
        <select v-model="dong">
            <option value="">:: 선택 ::</option>
            <option :value="item.dong" v-for="item in dongList">{{item.dong}}</option>
        </select>
        <button @click="fnSearch">검색</button>
        <table>
            <tr>
                <th>시</th>
                <th>구</th>
                <th>동</th>
                <th>X 좌표</th>
                <th>Y 좌표</th>
            </tr>
            <tr v-for="item in list">
                <td>{{item.si}}</td>
                <td>{{item.gu}}</td>
                <td>{{item.dong}}</td>
                <td>{{item.nx}}</td>
                <td>{{item.ny}}</td>
            </tr>
        </table>
        <a href="javascript:;" @click="fnPreList" v-if="startPage > 1">◀</a>
        <a href="javascript:;" v-for="num in pageList" id="index" @click="fnpageChange(num)">
            <span :class="{active : page == num}">
                    {{num}}
            </span>
        </a>
        <a href="javascript:;" @click="fnNextList" v-if="endPage < index">▶</a>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
               list : {},
               page: 1,
               pageSize : 20,
               index : 0,
               startPage : 0,
               endPage : 0,
               pageList: [],
               siList : [],
               si : "", // 선택한 시/도의 값
               guList : [],
               gu : "", // 선택한 구 값
               dong : "",
               dongList: []
            };
        },
        methods: {
            fnCalculatePaging (){
                let self = this;    
                const pageBlockSize = 10;
                const currentBlock = Math.ceil(self.page / pageBlockSize);
                self.startPage = (currentBlock - 1) * pageBlockSize + 1;
                let endPage = self.startPage + pageBlockSize - 1;

                if(endPage > self.index){
                    endPage = self.index;
                }
                self.endPage = endPage;

                self.pageList = [];
                for(let i = self.startPage; i <= self.endPage; i++){
                    self.pageList.push(i);
                }
            },
            fnAreaList: function () {
                let self = this;
                let param = {
                    page : (self.page-1) * self.pageSize,
                    pageSize : self.pageSize,
                    si : self.si,
                    gu : self.gu,
                    dong : self.dong
                };
                $.ajax({
                    url: "/area/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt / self.pageSize);
                        self.fnCalculatePaging();
                    }
                });
            },
            fnpageChange (num){
                let self = this;
                self.page = num;
                self.fnAreaList();
            },
            fnPreList(){
                let self = this;
                self.fnpageChange(self.startPage - 1);
            },
            fnNextList(){
                let self = this;
                self.fnpageChange(self.endPage + 1);
            },
            fnSiList: function () {
                let self = this;
                let param = {
                };
                $.ajax({
                    url: "/area/si.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.siList = data.siList;
                    }
                });
            },
            fnSiChange() {
                let self = this;
                self.gu = "";
                self.dong = "";
                self.dongList = [];
                self.fnGuList(); 
                
            },
             fnGuChange() {
                  let self = this;
                  self.dong = "";
                  self.fnDongList(); 
              },
            fnSearch (){
                let self = this;
                self.page = 1;
                self.fnAreaList();
            },
            fnGuList: function () {
                let self = this;      
                let param = {
                    si : self.si
                };
                $.ajax({
                    url: "/area/gu.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.guList = data.guList;
                    }
                });
            },
            fnDongList: function () {
                let self = this;      
                let param = {
                    si : self.si,
                    gu : self.gu
                };
                $.ajax({
                    url: "/area/dong.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.dongList = data.dongList;
                    }
                });
            },
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnAreaList();
            self.fnSiList();
        }
    });

    app.mount('#app');
</script>