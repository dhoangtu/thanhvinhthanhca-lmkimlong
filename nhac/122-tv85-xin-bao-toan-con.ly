% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Xin Bảo Toàn Con" }
  composer = "Tv. 85"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a4. bf16 (a) |
  g4 \tuplet 3/2 { c8 g e } |
  f4. f16 f |
  f8 d d bf' |
  bf4. c8 |
  a2 |
  g8. f16 d8 f |
  g4 \tuplet 3/2 { f8 g a } |
  bf4. bf16 g |
  a8. c16 \tuplet 3/2 { g8 g a } |
  f2 ~ |
  f4 r8 \bar "||" \break
  
  a16 a |
  a4. f8 |
  bf4. g8 |
  g8. bf16 c8 g |
  a4 r8 g16 g |
  e8 f4 g8 |
  c,2 |
  g'4. g16 a |
  f8 bf g (bf) |
  c4. c,8 |
  g'4. g16 g |
  e8 g4 g8 |
  f2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*11
  r4.
  f16 f |
  f4. ef8 |
  d4. d8 |
  e8. g16 a8 e |
  f4r8 b,!16 b |
  c8 d4 b!8 |
  c2 |
  b!4. c16 cs |
  d8 g f4 |
  e4. c8 |
  b!4. b16 b |
  c8 c4 bf8 |
  a2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Xin lắng tai và đáp lời con
      Thân con đây nghèo hèn túng quẫn Chúa ơi
      Xin bảo toàn mạng con vì con trung hiếu,
      cứu độ con vì con tin kính Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Con ước mong được mãi mừng vui
	    Khi con nâng hồn về tới Chúa,
	    Chúa ơi
	    Chúa nhân hậu khoan dung cùng ai kêu khấn,
	    tiếng nài van Ngài lưu tâm đáp lại.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Muôn sắc dân Ngài đã dựng nên
	    Nay hân hoan về phục bái trước Thánh Nhan
	    Để ca ngợi tôn vinh Ngài thực cao cả,
	    đã thực thi ngàn uy công lẫy lừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Xin chiếu soi đường chính nẻo ngay,
	    Cho con luôn bền lòng tiến bước, Chúa ơi
	    Xin cho lòng con đây trọn niềm tin kính,
	    biết thành tâm ngợi ca danh thánh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con xướng ca, thành kính tạ ơn,
	    Thân con đây được Ngài cứu thoát hố sâu
	    Như biển trời bao la, tình yêu thương Chúa,
	    suốt đời con nguyện tôn vinh tán tụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Xin đoái trông và hãy dủ thương,
	    Ban cho con một điềm báo phúc, Chúa ơi
	    Để quân thù con nay một phne điêu đứng,
	    thấy Ngài thương ủi an tôi tớ này.
    }
  >>
  \set stanza = "ĐK:"
  Xin thương con, lạy Chúa,
  Ngài là Thiên Chúa của con,
  con kêu cầu lên suốt ngày.
  Xin cho cõi lòng đây mừng vui,
  Vì con nâng tâm hồn tới Chúa luôn.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2))
  ragged-bottom = ##t
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
