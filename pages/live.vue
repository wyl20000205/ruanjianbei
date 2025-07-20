<template>
    <div id="pages_live">
        <div class="head">
            <p @click="cancel_live">完成面试</p>
        </div>
        <div class="main">
            <div class="left">
                <p class="title"><em>摄像头</em><em class="check_text">{{check_text}}</em></p>
                <video id="videoFeed_0" autoplay playsinline></video>
                <canvas id="canvas" class="hidden"></canvas> 
            </div>
            <div class="right">
                <p class="title">面试官</p>
                <video id="videoFeed_1" autoplay playsinline></video>
                <!-- <canvas id="canvas" class="hidden"></canvas> For capturing frames -->
                <div id="personal_info">
                    <div>
                    <p>姓名: 韦天韦</p>
                    <p>学校: 广东科技大学</p>
                    <p>专业: 计算机科学</p>
                    <p>岗位: 人工智能讲师</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer">
            <div class="f1">
                <p>面部分析</p>
                <div>{{face_compute}}</div>
            </div>
            <div class="f2">
                <p>语音分析</p>
                <div>{{sound_compute}}</div>
            </div>
            <div class="f3">
                <p>给出建议</p>
                <div>{{suggest_compute}}</div>
            </div>
        </div>
        <div id="copyright">
            <p>感谢科大讯飞提供技术服务</p>
        </div>
        <Transition name="show_live" tip="show_live" mode="out-in">
        <div id="show_live" v-show="show_live">
          <div class="back" @click="show_live = false"></div>
          <div class="content">
           <p class="title">确定完成面试? 🤔</p>
           <p class="btn"><em @click="toggle_estimate">确定</em><em @click="show_live = false">取消</em></p>
          </div>
        </div>
    </Transition>
    <Transition name="show_estimate" tip="show_estimate" mode="out-in">
        <div id="show_estimate" v-show="show_estimate">
          <div class="back" @click="show_estimate = false"></div>
          <div class="content">
           <p class="title">{{title}}</p>
           <p class="progress"><em v-for="(v,i) in progress_text" :key="i" :c='finish_index' :class="{'black':i<finish_index}">{{v}}</em> <i :style="{right:right_offset}"></i></p>
           <div class="estimate_main">
            
    <Transition name="show_estimate_1" tip="show_estimate_1" mode="out-in">
            <div id="estimate_1" v-show="start_index == 0">
            <pre class="s1">{{estimate_1_text}}</pre>
            <p><em>评分</em> <em>{{grade[0]}}/100</em></p>
            </div>
    </Transition>
    <Transition name="show_estimate_2" tip="show_estimate_1" mode="out-in">
            <div id="estimate_2" v-show="start_index == 1">
            <pre class="s1">{{estimate_2_text}}</pre>
            <p><em>评分</em> <em>{{grade[1]}}/100</em></p>
            </div>
    </Transition>
    <Transition name="show_estimate_3" tip="show_estimate_1" mode="out-in">
            <div id="estimate_3" v-show="start_index == 2">
            <pre class="s1">{{estimate_3_text}}</pre>
            <p><em>评分</em> <em>{{grade[2]}}/100</em></p>
            </div>
    </Transition>
    <Transition name="show_estimate_4" tip="show_estimate_1" mode="out-in">
            <div id="estimate_4" v-show="start_index == 3">
            <div class="section_1">
                <div id="graph_1"></div>
                <div id="graph_2"></div>
                <div id="graph_3"></div>
            </div>
            <p class="exit_issue">主要问题:{{exit_issue}}</p>
            <p class="system_suggest">系统建议:{{system_suggest}}</p>
            <p><em>推荐个性化学习：</em><em @click="go_where(2)">个人简历评价</em><em @click="go_where(3)">行业面试题库</em><em @click="go_where(4)">表达训练视频</em><em @click="go_where(5)">岗位技能课程</em></p>
            </div>
    </Transition>
           </div>
           <div class="estimate_footer">
            <p @click="next_progress">{{last_text}}</p>
           </div>
          </div>
        </div>
    </Transition>
    </div>
</template>

<script setup>

let check_text = ref('');
import * as echarts from 'echarts';
let title =ref('请稍等，正在评估您的面试情况 😎')
let exit_issue = ref('0')
let system_suggest = ref('0')
let grade = ref([0, 0, 0, 0]);
let compute_grade = (dom=0,target = parseInt(Math.ceil(Math.random()*20)+60) ) => {
     let c = setInterval(() => {
     grade.value[dom]++
        if(target == grade.value[dom]){
            clearInterval(c);
        }
    }, 40);
}
let show_live= ref(false);
let show_estimate= ref(false);
let finish_index = ref(0);
let start_index = ref(0);
let last_text = ref('下一步');
let estimate_1_text = ref('请稍等，正在评估您的面部分析结果');
let estimate_2_text = ref('请稍等，正在评估您的语音分析结果');
let estimate_3_text = ref('请稍等，正在评估您的建议分析结果');
let progress_text = ref(['面部分析', '语音分析', '系统建议', '最后总结']);
let right_offset = ref(228.5);
import OpenAI from "openai";
let toggle_estimate = ()=>{
    show_live.value = false;
    setTimeout(async () => {
    show_estimate.value = true;
     await streamResponse('假如在面试，你是面试官，以面试官的口吻评价你的面试者常见微表情、肢体语言分析结果和建议，添加少量emoji,不要出现字数，130-200字', (text) => {
            estimate_1_text.value = text;
        });
compute_grade();

        finish_index.value++; 
    }, 100);
}
let go_where = (i)=>{
    if(i == 1){
       
    }else if(i == 2){
        window.open('/resume', '_blank');
    }else if(i == 3){
        window.open('/exam', '_blank');
    }else if(i == 4){
        window.open('/video', '_blank');
    }else{
        window.open('/skill', '_blank');
    }
}
let cancel_live = () => {
  show_live.value = true;
};
let next_progress  = async ()=>{
    start_index.value++;
    if (start_index.value > 3) return
        right_offset.value = `${228.5 - (finish_index.value * 76)}px`;
        if (start_index.value == 1) {
           await streamResponse('假如在面试，你是面试官，以面试官的口吻评价你的面试者它的语音分析结果和建议，添加少量emoji,不要出现字数，130-200字', (text) => {
                estimate_2_text.value = text;
            });
            compute_grade(1)
            finish_index.value++;
        }else if( start_index.value == 2) {
            await streamResponse('假如在面试，你是面试官，以面试官的口吻给出你的面试者面试建议，添加少量emoji,不要出现字数，130-200字', (text) => {
                estimate_3_text.value = text;
            });
            compute_grade(2)
            finish_index.value++;
        }else if(start_index.value == 3){
           last_text.value = '已完成';
            finish_index.value++;
            setTimeout(() => {
                grenerte_graph('graph_1', '面部分析', grade.value[0]);
                grenerte_graph('graph_2', '语音分析', grade.value[1]);
                grenerte_graph('graph_3', '总体评分', (grade.value[0] + grade.value[1])/2);
            }, 1000);

            await streamResponse('假如在面试，你是面试官，以面试官的口吻评价你的面试者常见微表情、肢体语言分析结果和建议，添加少量emoji,不要出现字数，50字左右', (text) => {
            exit_issue.value = text;
        });
        await streamResponse('假如在面试，你是面试官，以面试官的口吻评价你的面试者常见微表情、肢体语言分析结果和建议，添加少量emoji,50字左右', (text) => {
            system_suggest.value = text;
        });
        title.value = '面试评估结果已完成，感谢您的参与！ 🎉';


        }
}
let grenerte_graph = (dom,title,score)=>{
var chartDom = document.getElementById(dom);
let myChart = echarts.init(chartDom);
let option = {
  series: [
    {
      type: 'gauge',
      startAngle: 180,
      endAngle: 0,
      center: ['50%', '75%'],
      radius: '90%',
      min: 0,
      max: 1,
      splitNumber: 8,
      axisLine: {
        lineStyle: {
          width: 2,
          color: [
            [0.25, '#7CFFB2'],
            [0.5, '#FDDD60'],
            [0.75, '#58D9F9'],
            [1, '#FF6E76']
          ]
        }
      },
      pointer: {
        icon: 'path://M12.8,0.7l12,40.1H0.7L12.8,0.7z',
        length: '12%',
        width: 10,
        offsetCenter: [0, '-60%'],
        itemStyle: {
          color: 'auto'
        }
      },
      axisTick: {
        length: 12,
        lineStyle: {
          color: 'auto',
          width: 2
        }
      },
      splitLine: {
        length: 20,
        lineStyle: {
          color: 'auto',
          width: 2
        }
      },
      axisLabel: {
        color: '#464646',
        fontSize: 10,
        distance: -40,
        rotate: 'tangential',
        formatter: function (value) {
          if (value === 0.875) {
            return '优秀';
          } else if (value === 0.625) {
            return '合格';
          } else if (value === 0.375) {
            return '勉强';
          } else if (value === 0.125) {
            return '较差';
          }
          return '';
        }
      },
      title: {
        offsetCenter: [0, '-10%'],
        fontSize: 10
      },
      detail: {
        fontSize: 10,
        offsetCenter: [0, '-35%'],
        valueAnimation: true,
        formatter: function (value) {
          return Math.round(value * 100) + '';
        },
        color: 'inherit'
      },
      data: [
        {
          value: score*0.01, 
          name: title
        }
      ]
    }
  ]
};
option && myChart.setOption(option);
}
const openai = new OpenAI({
        baseURL: 'https://api.deepseek.com',
        apiKey: '',
        dangerouslyAllowBrowser: true 
});
async function streamResponse(question, updateCallback) {
    let fullResponse = '';
    try {
        const stream = await openai.chat.completions.create({
            messages: [{ role: "system", content: question }],
            model: "deepseek-chat",
            stream: true,  // 启用流式响应
        });

        for await (const chunk of stream) {
            const content = chunk.choices[0]?.delta?.content || '';
            // content = content.replace("*",'')
            fullResponse += content;
            fullResponse = fullResponse.replace('*','')
            // 更新回调函数，逐字传递内容
            updateCallback(fullResponse);
            
            // 添加微小延迟使逐字效果更明显
            await new Promise(resolve => setTimeout(resolve, 20));
        }
    } catch (error) {
        console.error('流式请求出错:', error);
        updateCallback('请求出错，请重试');
    }
    
    return fullResponse;
}
async function main(qustion) {
  const completion = await openai.chat.completions.create({
    messages: [{ role: "system", content: qustion }],
    model: "deepseek-chat",
  });
  return completion.choices[0].message.content;
}


let face_compute = ref('面部分析结果将在此显示');
let sound_compute = ref('语音分析结果将在此显示');
let suggest_compute = ref('建议分析结果将在此显示');
useHead({
  title: "面试进行-大语言模型多模态模拟面试智能体系统",
});
let ccc = ref(0);

const APPID = ''; //https://console.xfyun.cn/services/image 这个网站获取APPID APISecret APIKey
const APISecret = '';
const APIKey = '';
const WSS_BASE_URL = 'wss://spark-api.cn-huabei-1.xf-yun.com/v2.1/image'; //固定，不需要修改
const host = 'spark-api.cn-huabei-1.xf-yun.com' //固定，不需要修改
const prompt_text = '"这张图片是什么内容，并且分析它的表情和神态内容信息"'

let keda_send_data = async(APPID,APIKey,APISecret,img_base64,bf)=>{
    function cleanBase64(base64Str) {
  return base64Str.replace(/^data:image\/\w+;base64,/, '');
    }
    function get_date() {
  return new Date().toUTCString();
    }
    function safeBtoa(str) {
  return btoa(unescape(encodeURIComponent(str)));
    }
    function buildWebSocketUrl(baseUrl, params) {
  const searchParams = new URLSearchParams();
  for (const [key, value] of Object.entries(params)) {
    searchParams.append(key, value);
  }
  return `${baseUrl}?${searchParams.toString()}`;
    }
    async function generateSignature() {
  const signingStr = [
    `host: spark-api.cn-huabei-1.xf-yun.com`,
    `date: ${get_date()}`,
    `GET /v2.1/image HTTP/1.1`
  ].join('\n');

  const encoder = new TextEncoder();
  const key = await crypto.subtle.importKey(
    'raw',
    encoder.encode(APISecret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign']
  );
  const signature = await crypto.subtle.sign('HMAC', key, encoder.encode(signingStr));
  return btoa(String.fromCharCode(...new Uint8Array(signature)));
    }
    const signature = await generateSignature();
    const authorization_origin = [
      `api_key="${APIKey}"`,
      `algorithm="hmac-sha256"`,
      `headers="host date request-line"`,
      `signature="${signature}"`
    ].join(', ');
    const extra_v = {
          authorization: safeBtoa(authorization_origin),
          date: get_date(),
          host, 
    };
    const wsUrl = buildWebSocketUrl(WSS_BASE_URL, extra_v);
    const socket = new WebSocket(wsUrl);
    socket.onopen = () => {
      socket.send(JSON.stringify({
      "header": {
        "app_id": APPID,
        "uid": "39769795890"//随便填
      },
      "parameter": {
        "chat": {
            "domain": "imagev3",
            "temperature": 0.5,
            "top_k": 4,
            "max_tokens": 2028
        }
      },
      "payload": {
        "message": {
            "text": [
                {
                    "role": "user",
                    "content":cleanBase64(img_base64) ,
                    "content_type": "image"
                },
                {
                    "role": "user",
                    "content": prompt_text,
                    "content_type": "text"
                }
            ]
        }
      }
}));

    };
    socket.onerror = (e) => console.error('Error:', e);
    socket.onmessage = (event) => {
    const response = JSON.parse(event.data);
    if (response.header.code === 0) {
        bf(response.payload.choices.text[0].content)
    } else {
        alert('敏感图片，请求失败')
      console.error("请求失败:", response.header.message);
      return -1
    }
 }
}


onMounted(async() => {
          

   document.body.style.background = "#F2F2F2";
   const video0 = document.getElementById('videoFeed_0');
   const video1 = document.getElementById('videoFeed_1');
   const canvas = document.getElementById('canvas');
   let baseURL = 'http://localhost:8080'
   let stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: false });
   video0.srcObject = stream;
   video1.srcObject = stream;
   let time_gap = 10000
   let introduction = ',仅翻译成中文,不需要解析它:';
   let introduction1 = 'Observe this picture, describe its content, and analyze the facial expressions';
   let sound_introduction = '在面试,这是它说的话，仅猜测它现在可能语音情绪情况,建议带着语气两字 不用分点,50个字就行，带emoji:';
   let suggest_introduction = '在面试,指出他的面试不良行为，给出矫正中文建议,不用分点,50个字就行,带emoji:';
        async function sendChatCompletionRequest(instruction, imageBase64URL) {
            const response = await fetch(`${baseURL}/v1/chat/completions`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    max_tokens: 100,
                    messages: [
                        { role: 'user', content: [
                            { type: 'text', text: instruction },
                            { type: 'image_url', image_url: {
                                url: imageBase64URL,
                            } }
                        ] },
                    ]
                })
            });
            if (!response.ok) {
                const errorData = await response.text();
                return `Server error: ${response.status} - ${errorData}`;
            }
            const data = await response.json();
            return data.choices[0].message.content;
        }

        function captureImage() {
            if (!stream || !video0.videoWidth) {
                console.warn("Video stream not ready for capture.");
                return null;
            }
            canvas.width = video0.videoWidth;
            canvas.height = video0.videoHeight;
            const context = canvas.getContext('2d');
            context.drawImage(video0, 0, 0, canvas.width, canvas.height);
            return canvas.toDataURL('image/jpeg', 1); // Use JPEG for smaller size, 0.8 quality
        }

async function sendData() {
    // 每次执行前清空历史数据
    face_compute.value = "";
    sound_compute.value = "";
    suggest_compute.value = "";

    const imageBase64URL = captureImage();
    if (!imageBase64URL) return;

    // 发送数据并获取最新结果（不叠加）
    await new Promise((resolve) => {
        keda_send_data(APPID, APIKey, APISecret, imageBase64URL, (text) => {
            face_compute.value += text; // 直接赋值，而非 +=
            resolve();
        });
    });

    if (/酒|锅头/.test(face_compute.value)) {
        alert('检测到面试者喝酒 😅，请注意！');
    }

    await streamResponse(`${face_compute.value}${sound_introduction}`, (text) => {
        sound_compute.value = text;
    });

    await streamResponse(`${face_compute.value}${suggest_introduction}`, (text) => {
        suggest_compute.value = text;
    });
}

setInterval(sendData, time_gap);

        // window.addEventListener('beforeunload', () => {
        //     if (stream) {
        //         stream.getTracks().forEach(track => track.stop());
        //     }
        //     if (intervalId) {
        //         clearInterval(intervalId);
        //     }
        // });


  
         
});
</script>

<style lang="less" >
.show_estimate_1-enter-active,
.show_estimate_1-leave-active,
.show_estimate_2-enter-active,
.show_estimate_2-leave-active,
.show_estimate_3-enter-active,
.show_estimate_3-leave-active,
.show_estimate_4-enter-active,
.show_estimate_5-leave-active,
.show_live-enter-active,
.show_live-leave-active,
.show_estimate-enter-active,
.show_estimate-leave-active {
  transition: all 0.3s ease; /* 添加 easing 函数使过渡更平滑 */
}


.show_live-enter-from,
.show_live-leave-to,
.show_estimate-enter-from,
.show_estimate-leave-to {
  opacity: 0;
  filter: blur(1px);
}

.show_estimate_1-enter-from,
.show_estimate_1-leave-to,
.show_estimate_2-enter-from,
.show_estimate_2-leave-to,
.show_estimate_3-enter-from,
.show_estimate_3-leave-to,
.show_estimate_4-enter-from,
.show_estimate_5-leave-to{
     opacity: 0;
     width: 0;
}

 #pages_live{
    width: 90%;
    margin: 0 auto 0 auto;
    .black{
        color: black!important;
    }
    .head{
    display: flex;
        margin-bottom: 20px;
        color: #006FC9;
        width: 100%;
        text-align: right;
        cursor: pointer;
        margin-top: 15px;
        font-size: 18px;
        justify-content: flex-end;
        p{
            margin-right: 20px;
        }
        >p:nth-of-type(1){
            font-weight: bold;
        }
    }
    .main{
        width: 67.5%;
        display: flex;
        margin: 0 auto 20px auto;
        justify-content: space-between;
        .title{
            margin-bottom: 15px;
        }
        .left{
            .title{
                em{
                    margin-right: 100px;
                }
                .check_text{
                    color: red;
                }
            }
        }
        .right{
        video{
            margin-bottom: 20px;

        }
            #personal_info{
                background: white;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 125px;
                border-radius: 4px;
                width:300px;
                box-shadow: rgba(0, 0, 0, 0.133) 0px 1.6px 3.6px 0px, rgba(0, 0, 0, 0.11) 0px 0.3px 0.9px 0px;
                >div{
                    width: 90%;
                    height: 90%;
                    margin-top: 15px;
                    p{
                        margin-bottom: 10px;
                        font-size: 14px;
                    }
                }
               
            }
        }
    }
    .footer{
        width: 67.5%;
        margin: 0 auto 15px auto;
        height: 250px;
        display: flex;
        >div{
            width: 45%;
            height: 100%;
            background-color: white;
            margin-right: 20px;
            border-radius: 3px;
            box-shadow: rgba(0, 0, 0, 0.133) 0px 1.6px 3.6px 0px, rgba(0, 0, 0, 0.11) 0px 0.3px 0.9px 0px;
            >p{
                height: 25px;
                width: 90%;
                margin: 10px auto 0 auto;
                color: #424260;
                border-bottom: 1px solid #E0E0E0;
            }
            >div{
                width: 90%;
                margin: 10px auto 0 auto;
                height: 180px;
                font-size: 14px;
                color: #424260;
            }
        }
        >div:nth-last-of-type(1){
            margin-right: 0;
        }

    }
    #show_live{
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(200, 200, 200, .9);
        .back{
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .content{
            position: absolute;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            width: 30%;
            height: 150px;
            border-radius: 4px;
            border: 1px solid #E0E0E0;
            .title{
                font-size: 20px;
                text-align: center;
                margin-top: 20px;
                margin-bottom: 40px;
            }
            .btn{
                width: 90%;
                margin: 0 auto;
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
                em{
                    transition: all 0.5s;
                    cursor: pointer;
                    color: #006FC9;
                    font-size: 18px;
                    &:hover{
                        color: #004A8F;
                    }
                }
                em:nth-of-type(1){
                    color: black;
                    border: 1px solid black;
                    padding: 5px 20px;
                    background: white;
                }
                em:nth-of-type(1):hover{
                    border: 1px solid black;
                    color: white;
                    background: black;
                }
                em:nth-of-type(2){
                    color: white;
                    border: 1px solid black;
                    padding: 5px 20px;
                    background: black;
                }
            }
        }
    }
    #show_estimate{
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(200, 200, 200, .9);
        .back{
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        .content{
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            width: 60%;
            height: 650px;
            border-radius: 4px;
            border: 1px solid #E0E0E0;
            .title{
                font-size: 20px;
                text-align: center;
                margin-top: 20px;
                margin-bottom: 25px;
            }
            .progress{
                position: relative;
                width: 90%;
                margin: 0 auto 35px auto;
                display: flex;
                justify-content: flex-end;
                font-size: 14px;
                i{
                    transition: all 0.5s;
                    width: 55px;
                    height: 2px;
                    background: gray;
                    position: absolute;
                    bottom: -5px;
                    right: 228.5px;
                }
                em{
                    transition: all 0.8s;
                    margin-left: 20px;
                    color:rgb(214, 214, 225);
                }
            }
            .estimate_main{
                width: 85%;
                margin: 0 auto;
                height: 460px;
                position: relative;
                // border: 1px solid #E0E0E0;
                >div{
                    position: absolute;
                    top: 0;
                    left: 0;
                    height: 95%;
                    width: 100%;
                      font-size: 17px;
                    .section_1{
                        display: flex;
                        width: 100%;
                        justify-content: space-between;
                    }
                      #graph_1,#graph_2, #graph_3, #graph_4{
                        width: 700px;
                        height: 190px;
                        margin-right: 50px;
                      }
                      #graph_3{
                        margin-right: 0;
                      }
                    .s1{
                        white-space: pre-wrap;
                        line-height: 25px;
                        height: 89%;
                    }
                    p{
                        font-size: 30px;
                    }
                   
                }
                 #estimate_4{
                        >p{
                            font-size: 18px;
                        }
                        .exit_issue{
                            margin-bottom: 40px;
                        }
                        .system_suggest{
                            margin-bottom: 40px;
                        }
                        >p:nth-last-of-type(1){
                            em:nth-of-type(n+1){
                                color: #006FC9;
                                font-size: 16px;
                                margin-right: 20px;
                                cursor: pointer;
                            }
                            em:nth-of-type(1){
                                color: black;
                                font-weight: bold;
                            }
                        }
                    }
            }
            .estimate_footer{
                width: 90%;
                margin: 0 auto;
                margin-top: 20px;
                background: white;
                display: flex;
                justify-content: flex-end;
                p{
                    border: 1px solid #E0E0E0;
                    padding: 5px 20px;
                    cursor: pointer;
                    transition: all 0.4s;
                    &:hover{
                        background: black;
                        color: white;
                    }
                }
            }
        }
    }

    #copyright{
        width: 67.5%;
        margin: 0 auto;
        text-align: center;
        font-size: 14px;
        color: gray;
    }
    #videoFeed_0{
        width: 500px;
        border-radius: 4px ;
    }
    #videoFeed_1{
        width: 300px;
        border-radius: 4px ;
    }
    .hidden{
        display:none;
    }
 }
</style>
