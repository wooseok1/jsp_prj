<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="비밀번호 찾기 페이지"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title</title>
<link rel="shorcut icon"
href="http://192.168.10.223/jsp_prj/common/images/paka.jpg">
<link rel="stylesheet" type="text/css"
href="http://192.168.10.223/jsp_prj/common/CSS/main_20240911.css">
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
.cont_header {
    padding-top: 75px;
    text-align: center;
    font-size: 14px;
    font-family: Arial, nbgr, '나눔바른고딕', '돋음';
    line-height: 24px;
}
.id_find_wrap {
	margin:0px auto;
	width: 900px;
    padding: 50px;
    border-top: 1px solid #222;
    background-color: #f8f8f8;
}
.find_handy {
	width:500px;
	height:400px;
    margin-top: 40px;
    margin: 0px auto;
}
.em {
    color: #ee6900;
    font-weight: normal;
}
.btn.btn_em {
    background-color: #333;
    color: #fff;
    height: 40px;
    cursor: pointer;
    padding: 0 15px;
    border: 1px solid #333;
    border-radius: 3px;
    margin-top: 10px;
    width: 375px;
}
.cont_area {
    padding-top: 60px;
}
.h3_tit {
    line-height: 50px;
    display: block; /* 입력 필드가 한 줄에 표시되도록 설정 */
}
.input_txt {
    margin-bottom: 5px; /* input 필드 사이 간격 추가 */
    display: block; /* 입력 필드가 한 줄에 표시되도록 설정 */
}

</style>
<script type="text/javascript">
$(function(){
    // 생년월일 숫자 및 길이 제한 검증
    $('#legl_birth_dy').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, ''); // 숫자만 입력되도록 함
        if (this.value.length > 6) {
            this.value = this.value.slice(0, 6); // 6자 초과하면 자름
        }
    });

    // 핸드폰 번호 숫자 및 길이 제한 검증
    $('#mob_no').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, ''); // 숫자만 입력되도록 함
        if (this.value.length > 8) {
            this.value = this.value.slice(0, 8); // 8자 초과하면 자름
        }
    });

    // 비밀번호 찾기 버튼 클릭 시 필수 입력 검증 및 서버 요청
    $('#btnSearch').on('click', function() {
        const userName = $('#user_nm').val();
        const birthDate = $('#legl_birth_dy').val();
        const mobileNo = $('#mob_no').val();

        // 입력 필드 검증
        if (!userName || !birthDate || !mobileNo) {
            alert('모든 필드를 입력해주세요.');
            return;
        }

        if (birthDate.length !== 6) {
            alert('생년월일은 6자리여야 합니다.');
            return;
        }

        if (mobileNo.length < 7 || mobileNo.length > 8) {
            alert('휴대전화번호는 7~8자리여야 합니다.');
            return;
        }

        // 서버에 비동기 요청을 보내고 응답 처리
        $.ajax({
            url: '#', // 비밀번호 재설정 처리하는 서버의 URL
            type: 'POST',
            data: {
                userName: userName,
                birthDate: birthDate,
                mobileNo: mobileNo
            },
            success: function(response) {
                if (response === 'success') {
                    alert('비밀번호 재설정 요청이 처리되었습니다.');
                } else if (response === 'not_found') {
                    alert('입력하신 정보와 일치하는 계정이 없습니다.');
                } else {
                    alert('알 수 없는 오류가 발생했습니다. 다시 시도해주세요.');
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});
</script>

</head>
<body>
<div class="cont_header">
	<h1 class="h1_tit">비밀번호 찾기</h1>
	<p class="h_desc">비밀번호가 기억나지 않으세요? 원하시는 방법을 선택해 비밀번호를 확인하실 수 있습니다.</p>
</div>
<div class="cont_area">
<div class="id_find_wrap">
<div class="find_handy">
	<div class="tit_box">
		<h2 class="h3_tit">비밀번호 발급</h2>
	</div>

	<div class="check_member_form">
		
		<span class="input_txt">
			<input type="text" class="text" id="user_nm" name="user_nm" placeholder="이름을 입력해주세요." title="이름을 입력해주세요." size=45><br>
		</span>
		<span class="input_txt">
			<input type="text" class="text" id="legl_birth_dy" name="legl_birth_dy" placeholder="법정생년월일 6자리를 입력해주세요." title="법정생년월일 6자리를 입력해주세요." maxlength="6" size=45><br>
		</span>
		<span class="input_txt">
			<input type="text" class="text" id="mob_no" name="mob_no" placeholder="휴대전화번호 뒤 7~8자리를 입력해주세요. (010 제외)" title="휴대전화번호 뒤 7~8자리를 입력해주세요. (01X 제외)" maxlength="8" size=45><br>
		</span>
			<div class="btn_sec">
				<button type="button" class="btn btn_em" id="btnSearch" onclick="비밀번호 재설정 페이지">비밀번호 재설정</button>
			</div>
		</div>
	</div>
	</div>
</div>
<!-- //간편 찾기 -->
</body>
</html>