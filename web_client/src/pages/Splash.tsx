import { useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowRight, Wifi, Signal, Battery } from "lucide-react";

const Splash = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen relative overflow-hidden bg-[#FF9B9B]">
      {/* Status Bar */}
      <div className="absolute top-0 left-0 right-0 z-20 px-6 pt-3 flex justify-between items-center text-gray-900">
        <span className="text-sm font-semibold">9:41</span>
        <div className="flex items-center gap-1">
          <Signal className="w-4 h-4" />
          <Wifi className="w-4 h-4" />
          <Battery className="w-5 h-5" />
        </div>
      </div>

      {/* Organic topographic pattern background */}
      <div className="absolute inset-0 opacity-20">
        <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="topographic" x="0" y="0" width="120" height="120" patternUnits="userSpaceOnUse">
              <path d="M20 60 Q35 40, 60 50 T100 60" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <path d="M15 75 Q30 60, 55 68 T95 78" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <path d="M25 90 Q40 75, 65 83 T105 93" stroke="rgba(255,255,255,0.35)" strokeWidth="1.5" fill="none"/>
              <path d="M18 35 Q38 25, 65 30 T108 40" stroke="rgba(255,255,255,0.4)" strokeWidth="2" fill="none"/>
              <circle cx="40" cy="85" r="18" stroke="rgba(255,255,255,0.35)" strokeWidth="2" fill="none"/>
              <circle cx="80" cy="30" r="25" stroke="rgba(255,255,255,0.35)" strokeWidth="2" fill="none"/>
              <ellipse cx="60" cy="100" rx="30" ry="18" stroke="rgba(255,255,255,0.35)" strokeWidth="1.5" fill="none"/>
              <path d="M10 50 Q25 35, 45 42 T75 50" stroke="rgba(255,255,255,0.3)" strokeWidth="1.5" fill="none"/>
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#topographic)" />
        </svg>
      </div>

      {/* White curved bottom section */}
      <div className="absolute bottom-0 left-0 right-0 h-[45%]">
        <svg className="w-full h-full" viewBox="0 0 430 400" preserveAspectRatio="none">
          <path 
            fill="#ffffff" 
            d="M0,140 Q215,80 430,140 L430,400 L0,400 Z"
          />
        </svg>
      </div>

      {/* Content */}
      <div className="relative z-10 flex flex-col items-start justify-between min-h-screen px-6 py-12 max-w-md mx-auto w-full">
        <div className="flex-1" />
        
        <div className="text-left mb-auto mt-auto w-full">
          <h1 className="text-[44px] leading-tight font-bold text-gray-900">
            Selamat Datang!
          </h1>
        </div>

        <div className="w-full flex justify-end items-center pr-2 mb-6">
          <button
            onClick={() => navigate("/login")}
            className="flex items-center gap-3 bg-transparent border-none p-0 transition-all duration-300 hover:scale-105"
          >
            <span className="text-[17px] font-normal text-gray-600">Lanjutkan</span>
            <div className="bg-primary rounded-full p-3.5 shadow-lg">
              <ArrowRight className="w-5 h-5 text-white" strokeWidth={2.5} />
            </div>
          </button>
        </div>

        {/* Bottom indicator */}
        <div className="w-full flex justify-center mb-2">
          <div className="w-32 h-1.5 bg-gray-900 rounded-full" />
        </div>
      </div>
    </div>
  );
};

export default Splash;
