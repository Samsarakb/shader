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

            // ʹ�øýṹ�嶨�嶥����ɫ�������
            struct v2f
            {
                // SV_POSITION�����ʾ��pos�洢�˶����ڲü��ռ��е�λ����Ϣ
                float4 pos : SV_POSITION;
                // COLOR0�������ڴ洢��ɫ��Ϣ������Ҫ�洢������ɫʱ���ɼ����� COLOR1 �� COLOR2��
                fixed3 color : COLOR0;
            };

            v2f vert(a2v v)
            {
                // ��������ṹ
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                
                // �����ߵ�ֵת�����ɫֵ�����ֵ�ģ���ϣ�����û�б�Ȼ�ķ��ߺ���ɫ��ת����ϵ������������ʾ���������˶δ��룩
                // ��Ϊ���߷��򣬸�������Χ��[-1, 1]��Ϊ������ת�䵽��ɫ�ķ�Χ[0, 1]�������������㣺
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            // ����������Ľṹ�崫��ƬԪ��ɫ����
            fixed4 frag(v2f i) : SV_Target
            {
                // �ṹ���ﶨ���color��fixed3���ͣ�����Ҳ���Խ��䶨��Ϊfixed4���ͣ�
                // �������ɫΪfixed4���ͣ�������Ҫ���ϵ��ĸ�����
                return fixed4(i.color, 1.0);
            }

            ENDCG
        }
    }
}
