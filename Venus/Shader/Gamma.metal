//
//  Gamma.metal
//  Venus
//
//  Created by Theresa on 2017/11/24.
//  Copyright © 2017年 Carolar. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

typedef struct {
    float4 renderedCoordinate [[position]];
    float2 textureCoordinate;
} GammaMappingVertex;

kernel void Gamma(texture2d<float, access::read> inTexture [[texture(0)]],
                  texture2d<float, access::write> outTexture [[texture(1)]],
                  device float *input [[buffer(0)]],
                  uint2 gid [[thread_position_in_grid]])
{
    const float gamma = input[0];
    float4 colorAtPixel = inTexture.read(gid);
    outTexture.write(float4(pow(colorAtPixel.rgb, gamma), 1), gid);
}

vertex GammaMappingVertex gammaVertex(unsigned int vertex_id [[ vertex_id ]]) {
    float4x4 renderedCoordinates = float4x4(float4( -1.0, -1.0, 0.0, 1.0 ),
                                            float4(  1.0, -1.0, 0.0, 1.0 ),
                                            float4( -1.0,  1.0, 0.0, 1.0 ),
                                            float4(  1.0,  1.0, 0.0, 1.0 ));
    
    float4x2 textureCoordinates = float4x2(float2( 0.0, 1.0 ),
                                           float2( 1.0, 1.0 ),
                                           float2( 0.0, 0.0 ),
                                           float2( 1.0, 0.0 ));
    GammaMappingVertex outVertex;
    outVertex.renderedCoordinate = renderedCoordinates[vertex_id];
    outVertex.textureCoordinate = textureCoordinates[vertex_id];
    
    return outVertex;
}

fragment half4 gammaFragment(GammaMappingVertex mappingVertex [[ stage_in ]],
                                 texture2d<float, access::sample> texture [[ texture(0) ]]) {
    constexpr sampler s(address::clamp_to_edge, filter::linear);

    half4 sam = half4(texture.sample(s, mappingVertex.textureCoordinate));
    return half4(pow(sam.rgb, 2.0), 1);
}

