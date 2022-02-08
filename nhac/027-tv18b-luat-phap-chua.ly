% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Luật Pháp Chúa" }
  composer = "Tv. 18B"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 d8 b' |
  b4 d8 b16 (a) |
  g8. a16 e8 g |
  a2 ~ |
  a4 g8 a16 (g) |
  e8. e16 g8 g |
  a c4 d8 |
  g,2 ~ |
  g4 r \bar "|." \break
  
  fs8. fs16 b8 fs |
  e4. d8 |
  e (g) a a |
  a2 |
  c8. c16 a8 d |
  d4. b16 (g) |
  e8 (d) e g |
  g4 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  d8 g |
  g4 fs8 [fs] |
  e8. d16 c8 e |
  d2 ~ |
  d4 e8 [d] |
  c8. c16 e8 e |
  fs e4 fs8 |
  g2 ~ |
  g4 r
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Luật pháp Chúa quý hơn vàng,
  hơn cả vàng y,
  Ngọt hơn mật, mật tự tàng ong đâu sánh tầy.
  <<
    {
      \set stanza = "1."
      Mệnh lệnh Chúa vẹn toàn bồi bổ cho tâm linh.
      Thánh ý Ngài vững chắc cho người dại nên khôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Lề luật Chúa minh bạch làm hỉ hoan con tim,
	    Huấn giới Ngài sáng suốt,
	    mắt phàm được khai quang.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lòng sợ Chúa thanh vẹn,
	    tồn tại qua muôn năm,
	    Phán quyết Ngài chính đáng,
	    hết thảy đều công minh.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Lòng này vẫn nguyện thề học hỏi cho tinh thông,
	    Quyết suốt đời nắm giữ sẽ được lợi trăm muôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nguyện cầu Chúa vui nhận lời miệng con thân thưa,
	    Khấn ước Ngài thấu suốt tiếng lòng thầm dâng lên.
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
  %page-count = #1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
}

TongNhip = {
  \key g \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
