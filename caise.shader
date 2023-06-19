Shader "Custom/caise"
{
   SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            // 使用该结构体定义顶点着色器的输出
            struct v2f
            {
                // SV_POSITION语义表示：pos存储了顶点在裁剪空间中的位置信息
                float4 pos : SV_POSITION;
                // COLOR0语义用于存储颜色信息，当需要存储更多颜色时，可继续用 COLOR1 、 COLOR2等
                fixed3 color : COLOR0;
            };

            v2f vert(a2v v)
            {
                // 声明输出结构
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                
                // 将法线的值转变成颜色值，呈现到模型上（这里没有必然的法线和颜色的转换关系，仅作案例演示，无需纠结此段代码）
                // 因为法线方向，各分量范围是[-1, 1]，为了让其转变到颜色的范围[0, 1]，故做如下运算：
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            // 将顶点输出的结构体传入片元着色器中
            fixed4 frag(v2f i) : SV_Target
            {
                // 结构体里定义的color是fixed3类型（我们也可以将其定义为fixed4类型）
                // 输出的颜色为fixed4类型，所以需要补上第四个分量
                return fixed4(i.color, 1.0);
            }

            ENDCG
        }
    }
}
