import Foundation

public struct Simulator {
    public static func simulateStep1(particles: [Particle]) -> Particle {
        let magMap = particles.sorted(by: { (p0, p1) -> Bool in
            let a0 = p0.a.magnitude
            let a1 = p1.a.magnitude
            let v0 = p0.v.magnitude
            let v1 = p1.v.magnitude
            if a0 == a1 {
                return v0 < v1
            } else {
                return a0 < a1
            }
        })
        return magMap.first!
    }
    
    public static func simulateStep2(particles: [Particle]) -> Int {
        for _ in 0..<10000 {
            var quantized: [IntVector3 : [Particle]] = [:]
            particles.forEach({
                guard !$0.isDestroyed else { return }
                $0.step()
                quantized[$0.quantization, default: []].append($0)
            })
            for key in quantized.keys {
                let qp = quantized[key, default:[]]
                guard qp.count > 1 else { continue }
                for (index, q0) in qp.enumerated() {
                    for q1 in qp.dropFirst(index + 1) {
                        if q0.p == q1.p {
                            q0.isDestroyed = true
                            q1.isDestroyed = true
                        }
                    }
                }
            }
        }
        return particles.filter({!$0.isDestroyed}).count
    }
}

