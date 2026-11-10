// 백엔드(FastAPI) 주소. 기본은 Railway(외부 접속), 주소 뒤에 ?api=local 을 붙이면 내 컴퓨터 서버 사용
const RAILWAY_API = "https://empathetic-simplicity-production-65a3.up.railway.app";
const LOCAL_API = "http://127.0.0.1:8000";
window.API_URL = new URLSearchParams(location.search).get("api") === "local" ? LOCAL_API : RAILWAY_API;
