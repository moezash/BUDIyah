import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";

const Splash = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen relative overflow-hidden bg-gradient-to-br from-[#FF9B9B] to-[#FFB5B5]">
      {/* Organic topographic pattern background */}
      <div className="absolute inset-0 opacity-30">
        <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="topographic" x="0" y="0" width="100" height="100" patternUnits="userSpaceOnUse">
              <path d="M20 50 Q30 30, 50 40 T80 50" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <path d="M10 60 Q25 45, 45 55 T75 65" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <path d="M15 30 Q35 20, 55 25 T85 35" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <circle cx="30" cy="70" r="15" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <circle cx="70" cy="25" r="20" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
              <ellipse cx="50" cy="80" rx="25" ry="15" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#topographic)" />
        </svg>
      </div>

      {/* White curved bottom section */}
      <div className="absolute bottom-0 left-0 right-0 h-2/5">
        <svg className="w-full h-full" viewBox="0 0 1440 320" preserveAspectRatio="none">
          <path 
            fill="#ffffff" 
            d="M0,160 Q360,100 720,140 T1440,120 L1440,320 L0,320 Z"
          />
        </svg>
      </div>

      {/* Content */}
      <div className="relative z-10 flex flex-col items-center justify-between min-h-screen px-8 py-12">
        <div className="flex-1" />
        
        <div className="text-center mb-32">
          <h1 className="text-5xl font-bold text-gray-900 mb-2">
            Selamat Datang!
          </h1>
        </div>

        <div className="mb-12">
          <Button
            onClick={() => navigate("/login")}
            className="bg-white/20 hover:bg-white/30 text-gray-700 backdrop-blur-sm border-none rounded-full px-8 py-6 flex items-center gap-3 shadow-lg transition-all duration-300 hover:scale-105"
          >
            <span className="text-lg font-medium">Lanjutkan</span>
            <div className="bg-primary rounded-full p-2">
              <ArrowRight className="w-5 h-5 text-white" />
            </div>
          </Button>
        </div>

        {/* Bottom indicator */}
        <div className="w-32 h-1.5 bg-gray-900 rounded-full" />
      </div>
    </div>
  );
};

export default Splash;
