% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Vì Thánh Danh Ngài"
  composer = "Gr. 14,17-21"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  g4 \tuplet 3/2 { g8 f a } |
  e4 r8 f16 d |
  g4. f16 g |
  a4 r8 a16 d |
  e4 \tuplet 3/2 { e8 d e } |
  d4 \tuplet 3/2 { bf8 d g, } |
  a8. a16 f (e) a8 |
  d,2 \bar "||"
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  a'4 \tuplet 3/2 { gs8 b a } |
  fs4 \tuplet 3/2 { fs8 e fs } |
  g4. fs8 |
  e4 r8 d16 g |
  g4 \tuplet 3/2 { fs8 fs a } |
  b2 |
  cs4. d16 d |
  a4 \tuplet 3/2 { fs8 g a } |
  b4. b8 |
  a4 e'8 e |
  d2 ~ |
  d4 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*8
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  cs4 \tuplet 3/2 { b8 b cs } |
  d4 \tuplet 3/2 { d8 cs d } |
  e4. d8 |
  cs4 r8 d16 d |
  b4 \tuplet 3/2 { d8 d fs } |
  g2 |
  a4. b16 g |
  fs4 \tuplet 3/2 { d8 e fs } |
  g4. g8 |
  fs4 g8 a |
  fs2 ~ |
  fs4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Mắt tôi tuôn trào suối lệ,
      suốt ngày đêm mà không ngớt,
      Vì trinh nữ, con gái dân tôi
      bị đánh trọng thương hết đường chữa chạy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Bước chân ra ngoài cánh đồng:
	    đó tử thi bị gươm giết,
	    Vào trong phố: cơn đói lây lan,
	    tư tế, ngôn sứ tất tưởi nín lặng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa nay, hay đã rẫy từ, chán Giu -- đa,
	    nhờm Si -- on,
	    Mà sao Chúa luôn cứ đang tâm
	    đập đánh đoàn con hết đường chữa trị.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Chúng con trông đợi thái bình,
	    thế mà đâu gặp may mắn,
	    Hằng trông ước đôi phút an vui
	    mà cứ gặp bao khiếp sợ hãi hùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúng con nay nhận biết mình đã làm bao điều gian ác,
	    Và tiên bối sai lỗi phen,
	    thực hết đoàn con đắc tội với Ngài.
    }
  >>
  \set stanza = "ĐK:"
  Nhưng vì thánh danh Ngài, xin đừng chê chối chúng con,
  Đừng khinh khi tòa hiển vinh Chúa,
  Xin Chúa nhớ lại, đừng hủy Giao ước
  giữa Ngài với chúng con.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
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
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
