<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+JP:wght@400;700&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');

    body {
        font-family: 'Noto Serif JP', serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        background-image: url('https://path/to/japanese/pattern/background.jpg'); /* 배경 이미지 URL 수정 */
        background-size: cover;
        background-attachment: fixed;
    }

    .container {
        max-width: 800px;
        margin: 50px auto;
        background: rgba(255, 255, 255, 0.9); /* 반투명 배경 */
        padding: 40px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        border-radius: 10px;
        border: 2px solid #2c3e50;
    }

    h2 {
        color: #2c3e50;
        font-size: 32px;
        border-bottom: 2px solid #e74c3c;
        padding-bottom: 10px;
        margin-bottom: 20px;
        font-family: 'Kaushan Script', cursive;
    }

    p {
        color: #333;
        line-height: 1.8;
        font-size: 18px;
        margin: 20px 0;
    }

    .btn {
        display: inline-block;
        margin-top: 20px;
        padding: 12px 25px;
        text-decoration: none;
        color: #fff;
        background-color: #e74c3c;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        font-size: 16px;
    }

    .btn:hover {
        background-color: #c0392b;
        transform: translateY(-3px);
    }

    .btn-edit {
        background-color: #27ae60;
    }

    .btn-edit:hover {
        background-color: #1e8449;
    }

    .btn-delete {
        background-color: #e74c3c;
    }

    .btn-delete:hover {
        background-color: #c0392b;
    }

    .btn-return {
        background-color: #3498db;
        color: #fff;
    }

    .btn-return:hover {
        background-color: #2980b9;
    }

    h3 {
        color: #2c3e50;
        margin-top: 50px;
        font-size: 24px;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
        font-family: 'Kaushan Script', cursive;
    }

    .comments {
        margin-top: 30px;
    }

    .comment {
        margin-bottom: 20px;
        padding: 20px;
        background: rgba(255, 255, 255, 0.9); /* 반투명 배경 */
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border: 1px solid #ddd;
    }

    .comment-author {
        font-weight: bold;
        color: #2c3e50;
        font-size: 16px;
    }

    .comment-content {
        margin-top: 10px;
        color: #555;
        font-size: 14px;
    }

    .comment-date {
        font-size: 12px;
        color: #999;
        margin-top: 5px;
    }

    .comment-form {
        margin-top: 40px;
        background: rgba(255, 255, 255, 0.9); /* 반투명 배경 */
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border: 1px solid #ddd;
    }

    .comment-form textarea {
        width: 100%;
        height: 120px;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        resize: vertical;
        font-size: 14px;
        margin-bottom: 10px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    .comment-form button {
        padding: 12px 25px;
        color: #fff;
        background-color: #e74c3c;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        font-size: 16px;
    }

    .comment-form button:hover {
        background-color: #c0392b;
        transform: translateY(-3px);
    }
</style>
</head>
<body>
    <div class="container">
        <h2>${board.title}</h2>
        <p>${board.content}</p>
        <p><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:MM"/> </p>
    </div>
    <c:if test="${board.userId == userId}">
        <a class="btn btn-edit" href="${pageContext.request.contextPath}/board/edit?id=${board.id}">수정</a>
        <a class="btn btn-delete" href="${pageContext.request.contextPath}/board/delete?id=${board.id}">삭제</a>
    </c:if>

    <a class="btn btn-return" href="${pageContext.request.contextPath}/board/list?page=1">목록으로 돌아가기</a>

    <h3>댓글</h3>
    <div class="comments">
        <c:forEach var="comment" items="${comments}">
            <div class="comment">
                <div class="comment-author">${comment.author}</div>
                <div class="comment-content">${comment.content}</div>
                <div class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:MM"/></div>
            </div>
        </c:forEach>
    </div>

    <div class="comment-form">
        <form action="${pageContext.request.contextPath}/board/comment" method="post">
            <textarea name="content" placeholder="댓글을 작성하세요..."></textarea>
            <button type="submit">댓글 작성</button>
        </form>
    </div>
</body>
</html>
