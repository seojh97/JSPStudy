/**
 * 
 */function formValidate(frm){
    /*
    <form>에서 this를 통해 전달한 인수는 다음과 같다. 
    1. document.forms[0];
    2. document.myform;
    즉 <form> 태그의 DOM 객체이다. 
    */
    
    //아이디에 입력한 값이 있는지 확인한다. 
    if(frm.id.value==''){
        alert("아이디를 입력해주세요.");
        frm.id.focus();
        return false;
    }

    //아이디는 8~12자로 입력되었는지 검증
    if(!(frm.id.value.length>=8 && frm.id.value.length<=12)){
        //8~12자 사이가 아니라면..
        alert("아이디는 8~12자 사이만 가능합니다.");
        //입력된 값을 지우고 포커스를 이동한다. 
        frm.id.value = '';
        frm.id.focus();
        return false;
    }

    //아이디는 숫자로 시작할 수 없음
    /* 0과 9의 아스키코드값은 각각 48, 57이므로 아이디의 첫글자가
    만약 이 사이에 존재한다면 사용할 수 없는 아이디로 판단할 수 있다. */
    //입력한 아이디와 첫번째 문자, 아스키코드를 콘솔에서 확인한다. 
    console.log(frm.id.value, frm.id.value[0], 
        frm.id.value.charCodeAt(0));
    if(frm.id.value[0].charCodeAt(0)>=48 &&
            frm.id.value.charCodeAt(0)<=57){
        alert('아이디는 숫자로 시작할 수 없습니다.');
        frm.id.value = '';
        frm.id.focus();
        return false;
    }

    //아이디는 영문+숫자의 조합으로만 사용할 수 있다. 
    /* 아이디를 구성하는 각 문자가 소문자 a~z, 대문자 A~Z, 숫자 0~9
    사이가 아니라면 잘못된 문자가 포함된 경우이므로 전송을 중단한다.*/

    //아이디의 길이만큼 반복한다. 
    for(var i=0 ; i<frm.id.value.length ; i++){
        if(!((frm.id.value[i]>='a' && frm.id.value[i]<='z') ||
            (frm.id.value[i]>='A' && frm.id.value[i]<='Z') ||
            (frm.id.value[i]>='0' && frm.id.value[i]<='9'))){
            alert("아이디는 영문 및 숫자의 조합만 가능합니다.");
            frm.id.value='';
            frm.id.focus();
            return false; 
        }
    }


    //패스워드 입력 확인
    if(frm.pass1.value==''){
        alert("패스워드를 입력해주세요.");frm.pass1.focus();return false;
    }
    if(frm.pass2.value==''){
        alert("패스워드 확인을 입력해주세요.");frm.pass2.focus();return false;
    }
    //만약 입력한 패스워드가 일치하지 않는다면..
    if(frm.pass1.value!=frm.pass2.value){
        alert('패스워드가 일치하지 않습니다. 다시 입력해주세요.');
        //사용자가 입력한 패스워드를 지운다. 
        frm.pass1.value = '';
        frm.pass2.value = '';
        //입력상자로 포커싱 한다. 
        frm.pass1.focus();
        return false;
    }

    //폼 검증이 끝난후 서버로 전송 직후 로딩 이미지를 띄워준다. 
    document.getElementById("id_loading").style.display = 'block';
    //return false;
}

function inputEmail(frm){
    //이메일의 도메인을 선택한 경우의 value값 가져오기 
    var choiceDomain = frm.email_domain.value;
    if(choiceDomain==''){//--선택-- 부분을 선택한 경우..
        //입력한 모든 값을 지운다. 
        frm.email1.value = '';
        frm.email2.value = '';
        //아이디 입력란으로 포커싱한다.
        frm.email1.focus();
    }
    else if(choiceDomain=='직접입력'){//직접입력을 선택한 경우..
        //기존에 입력된 값을 지운다.
        frm.email2.value = '';
        //readonly 속성을 해제한다.
        frm.email2.readOnly = false;
        //포커스를 이동한다. 
        frm.email2.focus();
    }
    else{//포털 도메인을 선택한 경우..
        //선택한 도메인을 입력한다. 
        frm.email2.value = choiceDomain;
        //입력된 값을 수정할 수 없도록 readonly속성을 추가한다. 
        frm.email2.readOnly = true;
    }
}   
/* thisObj 입력상자에 inputLen 길이의 텍스트를 입력하면 nextName
엘리먼트로 포커스를 이동시킨다. */ 
function focusMove(thisObj, nextName, inputLen){
    //입력한 문자의 길이
    var strLen = thisObj.value.length;
    //제한 길이가 넘어가는지 확인 
    if(strLen >= inputLen){
        //alert("포커스 이동");
        /*
        eval() 함수는 문자열로 주어진 인수를 Javascript코드로 해석하여
        실행한다. 
        document.myform. => 문서객체를 이용한 DOM(form태그를 가리킴)
        nextName => 문자열이 전달된 매개변수
        객체와 문자열을 바로 연결하면 에러가 발생하므로 
        객체를 문자열로 변경한 후 eval()함수를 통해 JS코드로 재변환한다.
        */
        eval('document.myform.'+ nextName).focus();
    }  
} 
//아이디 중복확인 
function idCheck(fn){
    if(fn.id.value==''){
        alert("아이디를 입력후 중복확인 해주세요.");
        fn.id.focus();
    }
    else{
        //아이디 중복확인 창을 띄울때 입력한 아이디를 쿼리스트링으로 
        //넘겨준다. 
        window.open('RegiIdOverlap.jsp?id='+fn.id.value, 
            'idOver', 
            'width=500,height=300');
        //입력한 아이디를 수정할 수 없도록 속성을 추가한다. 
        fn.id.readOnly = true;
    }
}