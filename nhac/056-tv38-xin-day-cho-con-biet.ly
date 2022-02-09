% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Dạy Cho Con Biết" }
  composer = "Tv. 38"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c4 |
  g'4. e8 |
  d e4 g8 |
  a4 g8 c ~ |
  c c b e |
  a,4 a8 f ~ |
  f a d, f |
  g4 e16 (g) e (d) |
  c4.
  \afterGrace a'8 ({
    \override Flag.stroke-style = #"grace"
    b16)}
  \revert Flag.stroke-style
  g8 a4 g8 |
  c2 \bar "||" \break
  
  c8. c,16 c (e) f8 ~ |
  f f e f |
  \slashedGrace { a16 ( } g4) c8 c |
  \slashedGrace { a16 ( } g8.) a16 c,8 c16 (d) |
  \slashedGrace { e16 (d } e2) ~ |
  e4 \slashedGrace { d'16 ( } e8) d16 (c) |
  a8. g16 f8 f |
  g g e (d ~ |
  d4) d8 g |
  f8. g16 e8 d |
  c2 ~ |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lạy Chúa, xin dạy cho con biết:
  Đời con chung cuộc thế nào,
  tháng ngày đếm được là bao
  Để hiểu rằng:
  Kiếp phù du là thế
  <<
    {
      \set stanza = "1."
      Vẫn tự nhủ tâm: trông chừng đi đứng,
      Giữ lưỡi đừng nói gì lầm lỗi,
      Quyết câm miệng khi còn kẻ dữ đối mặt,
      Chẳng hé môi nói năng một lời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Thấy họ gặp may nghe lòng đau nhói,
	    Tâm can thì bấn loạn sục sôi
	    Tính suy hoài lại càng bừng lên như lửa,
	    Miệng lưỡi tôi nói không nên lời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ấy tuổi đời con đo vài gang tấc,
	    Kiếp sống này Chúa kể bằng không,
	    Sống trên đời con người chỉ như hơi thở,
	    Tựa bóng câu vút qua trên đường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Tính chuyện giầu sang,
	    xuôi ngược hôm sớm,
	    Nhắm mắt rồi biết thuộc về ai,
	    Thế nên rầy con còn đợi trông chi nữa,
	    Chỉ biết luôn vững tin nơi Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Cứu giùm mạng con khỏi vòng tội lỗi,
	    Con câm miệng bời Ngài làm thế.
	    Chúa thương tình mau dừng lại bao tai họa,
	    Ngài xuống tay khiến con tơi bời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Chúa trừng trị con như lời cảnh báo,
	    Bao mưu định mối mọt gặm tiêu,
	    Kiếp nhân trần bay vèo tựa như hơi thở,
	    Nguyện Chúa nghe tiếng con kêu cầu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Chúa nhậm lời con van nài tha thiết,
	    Khóc lóc hoài, Chúa đừng làm ngơ,
	    Kiếp lữ hành, thân phận kiều cư trôi nổi,
	    Rồi khuất đi cũng như bao người.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.7
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
